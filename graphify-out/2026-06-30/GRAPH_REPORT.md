# Graph Report - D:\BKP\KOM 2.0  (2026-06-30)

## Corpus Check
- cluster-only mode — file stats not available

## Summary
- 15 nodes · 10 edges · 7 communities (3 shown, 4 thin omitted)
- Extraction: 90% EXTRACTED · 10% INFERRED · 0% AMBIGUOUS · INFERRED: 1 edges (avg confidence: 0.9)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `50f92188`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- [[_COMMUNITY_Community 0|Community 0]]
- [[_COMMUNITY_Community 1|Community 1]]
- [[_COMMUNITY_Community 2|Community 2]]
- [[_COMMUNITY_Community 3|Community 3]]
- [[_COMMUNITY_Community 5|Community 5]]
- [[_COMMUNITY_Community 6|Community 6]]

## God Nodes (most connected - your core abstractions)
1. `KOM Cycle` - 3 edges
2. `KOM Radar` - 2 edges
3. `KOM Retrospect` - 2 edges
4. `KOM Registry` - 1 edges
5. `Loop Engineering` - 1 edges
6. `Graphify Integration` - 1 edges
7. `KOM 2.0 README` - 0 edges
8. `RFC-001 Architecture` - 0 edges

## Surprising Connections (you probably didn't know these)
- `Graphify Integration` --conceptually_related_to--> `KOM Cycle`  [EXTRACTED]
  .opencode/skills/kom-graphify/SKILL.md → kom/01-orientacao.md
- `Loop Engineering` --implements--> `KOM Cycle`  [EXTRACTED]
  kom/08-loop-engineering.md → kom/01-orientacao.md

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **The Three Mechanisms** — kom_registry, kom_radar, kom_retrospect [EXTRACTED 1.00]
- **KOM Six Phases** — kom_cycle, kom_loop_engineering, kom_graphify [INFERRED 0.85]

## Communities (7 total, 4 thin omitted)

### Community 0 - "Community 0"
Cohesion: 0.50
Nodes (3): Knowledge Registry, KOM Radar, KOM Registry

### Community 1 - "Community 1"
Cohesion: 0.67
Nodes (3): KOM Cycle, Graphify Integration, Loop Engineering

## Knowledge Gaps
- **5 isolated node(s):** `KOM 2.0 README`, `RFC-001 Architecture`, `KOM Registry`, `Loop Engineering`, `Graphify Integration`
  These have ≤1 connection - possible missing edges or undocumented components.
- **4 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `KOM Cycle` connect `Community 1` to `Community 0`?**
  _High betweenness centrality (0.143) - this node is a cross-community bridge._
- **Why does `KOM Retrospect` connect `Community 2` to `Community 0`?**
  _High betweenness centrality (0.077) - this node is a cross-community bridge._
- **What connects `KOM 2.0 README`, `RFC-001 Architecture`, `KOM Registry` to the rest of the system?**
  _5 weakly-connected nodes found - possible documentation gaps or missing edges._