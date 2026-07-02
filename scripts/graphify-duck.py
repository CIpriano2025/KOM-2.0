"""graphify-duck.py — DuckDB backend for Graphify knowledge graph

Usage:
  python scripts/graphify-duck.py build          # Import graph.json into DuckDB
  python scripts/graphify-duck.py query <sql>     # Run raw SQL
  python scripts/graphify-duck.py godnodes [N]    # Top N most connected nodes
  python scripts/graphify-duck.py path <A> <B>    # Shortest path between two nodes
  python scripts/graphify-duck.py impact <file>   # Dependencies of a file
  python scripts/graphify-duck.py explain <id>    # Node details + neighbors
  python scripts/graphify-duck.py stats           # Graph statistics
"""

import json
import argparse
import duckdb
import os
import sys

if sys.platform == "win32":
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(BASE, "graphify-out", "graph.duckdb")
JSON_PATH = os.path.join(BASE, "graphify-out", "graph.json")


def _connect(read_only=False):
    return duckdb.connect(DB_PATH, read_only=read_only)


def build():
    if not os.path.exists(JSON_PATH):
        print(f"graph.json not found at {JSON_PATH}")
        return

    with open(JSON_PATH, encoding="utf-8") as f:
        g = json.load(f)

    con = _connect()

    con.execute("CREATE OR REPLACE TABLE nodes ("
                "id TEXT PRIMARY KEY, label TEXT, norm_label TEXT, "
                "file_type TEXT, source_file TEXT, source_location TEXT, "
                "origin TEXT, community INT)")

    con.execute("CREATE OR REPLACE TABLE links ("
                "source TEXT, target TEXT, relation TEXT, "
                "confidence TEXT, confidence_score FLOAT, "
                "source_file TEXT, source_location TEXT, weight FLOAT)")

    con.execute("CREATE OR REPLACE TABLE hyperedges ("
                "id TEXT PRIMARY KEY, label TEXT, nodes JSON, "
                "relation TEXT, confidence TEXT, "
                "confidence_score FLOAT, source_file TEXT)")

    for n in g["nodes"]:
        con.execute("INSERT INTO nodes VALUES (?,?,?,?,?,?,?,?)",
                    (n["id"], n["label"], n.get("norm_label", ""),
                     n.get("file_type", ""), n.get("source_file", ""),
                     n.get("source_location", ""), n.get("_origin", ""),
                     n.get("community", -1)))

    for l in g.get("links", []):
        con.execute("INSERT INTO links VALUES (?,?,?,?,?,?,?,?)",
                    (l["source"], l["target"], l.get("relation", ""),
                     l.get("confidence", ""), l.get("confidence_score", 0.0),
                     l.get("source_file", ""), l.get("source_location", ""),
                     l.get("weight", 1.0)))

    for h in g.get("hyperedges", []):
        con.execute("INSERT INTO hyperedges VALUES (?,?,?,?,?,?,?)",
                    (h["id"], h["label"], json.dumps(h.get("nodes", [])),
                     h.get("relation", ""), h.get("confidence", ""),
                     h.get("confidence_score", 0.0), h.get("source_file", "")))

    con.execute("CREATE OR REPLACE TABLE graph_metadata AS "
                "SELECT COUNT(*) AS node_count, "
                "(SELECT COUNT(*) FROM links) AS link_count, "
                "(SELECT COUNT(DISTINCT community) FROM nodes WHERE community >= 0) AS community_count "
                "FROM nodes")

    con.execute("CREATE OR REPLACE TABLE communities AS "
                "SELECT community AS id, COUNT(*) AS node_count "
                "FROM nodes WHERE community >= 0 "
                "GROUP BY community ORDER BY node_count DESC")

    con.close()
    print(f"Imported {len(g['nodes'])} nodes, {len(g.get('links', []))} links into {DB_PATH}")


def query(sql):
    con = _connect(read_only=True)
    try:
        result = con.execute(sql).fetchdf()
        print(result.to_string(index=False))
    except Exception as e:
        print(f"Error: {e}")
    con.close()


def godnodes(limit=10):
    query(
        "SELECT n.label, n.file_type, n.source_file, COUNT(*) AS degree "
        "FROM nodes n "
        "JOIN links l ON n.id = l.source OR n.id = l.target "
        "GROUP BY n.id, n.label, n.file_type, n.source_file "
        "ORDER BY degree DESC "
        f"LIMIT {limit}"
    )


def path(source_id, target_id, max_depth=15):
    con = _connect(read_only=True)
    try:
        rows = con.execute("""
            WITH RECURSIVE p AS (
                SELECT source, target, [source, target] AS trail, 1 AS depth
                FROM links WHERE source = ?
                UNION ALL
                SELECT l.source, l.target, list_append(p.trail, l.target), p.depth + 1
                FROM p JOIN links l ON p.target = l.source
                WHERE NOT list_contains(p.trail, l.target) AND p.depth < ?
            )
            SELECT trail AS path FROM p WHERE target = ? ORDER BY depth LIMIT 1
        """, [source_id, max_depth, target_id]).fetchall()
        if rows:
            trail = rows[0][0]
            for i in range(len(trail) - 1):
                print(f"  {trail[i]} → {trail[i+1]}")
        else:
            print(f"No path found between '{source_id}' and '{target_id}'")
    except Exception as e:
        print(f"Error: {e}")
    con.close()


def impact(file_path):
    query(f"""
        SELECT DISTINCT l.relation, n2.label, n2.source_file
        FROM links l
        JOIN nodes n1 ON l.source = n1.id
        JOIN nodes n2 ON l.target = n2.id
        WHERE n1.source_file = '{file_path.replace("'", "''")}'
        UNION
        SELECT DISTINCT l.relation, n1.label, n1.source_file
        FROM links l
        JOIN nodes n1 ON l.target = n1.id
        JOIN nodes n2 ON l.source = n2.id
        WHERE n2.source_file = '{file_path.replace("'", "''")}'
    """)


def explain(node_id):
    con = _connect(read_only=True)
    try:
        n = con.execute("SELECT * FROM nodes WHERE id = ?", [node_id]).fetchdf()
        if len(n) == 0:
            print(f"Node '{node_id}' not found")
            con.close()
            return
        print("=== Node ===")
        for col in n.columns:
            print(f"  {col}: {n.iloc[0][col]}")
        print()
        neighbors = con.execute("""
            SELECT DISTINCT l.relation, n2.id, n2.label, n2.file_type
            FROM links l
            JOIN nodes n2 ON n2.id = CASE WHEN l.source = ? THEN l.target ELSE l.source END
            WHERE l.source = ? OR l.target = ?
        """, [node_id, node_id, node_id]).fetchdf()
        if len(neighbors) > 0:
            print(f"=== Neighbors ({len(neighbors)}) ===")
            for _, r in neighbors.iterrows():
                print(f"  {r['relation']} → {r['id']} ({r['label']}, {r['file_type']})")
    except Exception as e:
        print(f"Error: {e}")
    con.close()


def stats():
    query("SELECT * FROM graph_metadata")


def export():
    build()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Graphify DuckDB backend")
    parser.add_argument("action", choices=["build", "query", "godnodes", "path", "impact", "explain", "stats", "export"])
    parser.add_argument("args", nargs=argparse.REMAINDER)
    args = parser.parse_args()

    if args.action == "build":
        build()
    elif args.action == "query":
        query(" ".join(args.args))
    elif args.action == "godnodes":
        n = int(args.args[0]) if args.args else 10
        godnodes(n)
    elif args.action == "path":
        if len(args.args) < 2:
            print("Usage: python scripts/graphify-duck.py path <source_id> <target_id> [max_depth]")
        else:
            depth = int(args.args[2]) if len(args.args) > 2 else 15
            path(args.args[0], args.args[1], depth)
    elif args.action == "impact":
        impact(" ".join(args.args))
    elif args.action == "explain":
        explain(args.args[0]) if args.args else print("Usage: python scripts/graphify-duck.py explain <node_id>")
    elif args.action == "stats":
        stats()
    elif args.action == "export":
        export()
