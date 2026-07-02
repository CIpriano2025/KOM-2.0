---
name: kom-graphify
description: Integrates Graphify knowledge graph into the KOM 2.0 cycle. Use for codebase understanding, impact analysis, and context minimization during any KOM phase.
---

# KOM 2.0 — Graphify Integration

Graphify constrói um grafo de conhecimento do codebase. Esta skill integra o grafo nas 6 fases do KOM.

> ⚠️ **Graphify é um pacote externo.** O KOM 2.0 não o inclui. O usuário precisa instalar com `pip install graphifyy`. Se ele pedir para você instalar, use os comandos abaixo.

---

## Instalação (se o usuário solicitar)

```bash
pip install graphifyy
```

Opcional — configurar API key para melhor qualidade do grafo:

```bash
set GEMINI_API_KEY=sua-chave-aqui        # Windows PowerShell
$env:GEMINI_API_KEY="sua-chave-aqui"     # Windows PowerShell (alternativo)
export GEMINI_API_KEY="sua-chave-aqui"   # Linux/Mac
```

Buildar o grafo:

```bash
graphify .
```

Após mudanças no código (AST-only, sem custo):

```bash
graphify update .
```

---

## Gatilho

Ativado automaticamente em:
- **Início de sessão:** Buildar/atualizar o grafo via `graphify update .`
- **Fase 1 (Orientação):** Carregar `graphify-out/GRAPH_REPORT.md` para entender o codebase
- **Fase 2 (Arquitetura):** Identificar god nodes (módulos centrais) e comunidades
- **Fase 4 (Execução):** Usar `graphify query` para contexto mínimo
- **Fase 5 (Verificação):** Usar `graphify query` para análise de impacto

---

## Comandos

### Graphify nativo

| Comando | Quando usar |
|---|---|
| `graphify .` | Buildar grafo completo (primeira vez) |
| `graphify update .` | Atualizar grafo após mudanças (AST-only, sem API) |
| `graphify query "pergunta"` | Buscar contexto mínimo no grafo |
| `graphify path "A" "B"` | Descobrir relação entre dois nós |
| `graphify explain "conceito"` | Explicar um nó e seus vizinhos |

### DuckDB (consultas SQL diretas)

Requer `pip install duckdb`. Após `graphify update .`, execute `build` para importar.

| Comando | Quando usar |
|---|---|
| `python scripts/graphify-duck.py build` | Importar graph.json para DuckDB |
| `python scripts/graphify-duck.py query "<sql>"` | Consulta SQL direta no grafo |
| `python scripts/graphify-duck.py godnodes [N]` | Top N nós mais conectados (Fase 2) |
| `python scripts/graphify-duck.py path "A" "B"` | Caminho mais curto entre dois nós |
| `python scripts/graphify-duck.py impact "<arquivo>"` | Dependências de um arquivo (Radar) |
| `python scripts/graphify-duck.py explain "<id>"` | Detalhes + vizinhos de um nó |
| `python scripts/graphify-duck.py stats` | Estatísticas do grafo (nodes, links, comunidades) |

### Exemplos de consultas SQL úteis

```sql
-- Nós de código vs documento
SELECT file_type, COUNT(*) FROM nodes GROUP BY file_type;

-- Comunidades com mais nós
SELECT c.id, c.node_count FROM communities c ORDER BY c.node_count DESC LIMIT 5;

-- Dependências diretas de um arquivo
SELECT n.label, n.source_file FROM nodes n
JOIN links l ON n.id = l.target
JOIN nodes n2 ON l.source = n2.id
WHERE n2.source_file = 'kom/08-loop-engineering.md';

-- Buscar nó por label (quando não sabe o ID)
SELECT id, label, source_file FROM nodes WHERE label LIKE '%radar%';

-- Nós órfãos (sem conexões)
SELECT n.id, n.label FROM nodes n
LEFT JOIN links l ON n.id = l.source OR n.id = l.target
WHERE l.source IS NULL;
```

---

## Integração por Fase

### Fase 1 — Orientação
Carregue `graphify-out/GRAPH_REPORT.md` e use `python scripts/graphify-duck.py stats` para visão geral do codebase.

### Fase 2 — Arquitetura
Use `python scripts/graphify-duck.py godnodes 10` para identificar módulos centrais e `python scripts/graphify-duck.py query "SELECT community, COUNT(*) FROM nodes GROUP BY community ORDER BY 2 DESC"` para comunidades.

### Fase 4 — Execução
Use `python scripts/graphify-duck.py query "<sql>"` para contexto mínimo ao implementar.

### Fase 5 — Verificação
Use `python scripts/graphify-duck.py impact "<arquivo>"` para verificar impacto colateral de cada arquivo modificado.

---

## Notas

- Graphify é um complemento, não um substituto do KOM 2.0
- Requer Python 3.10+ e `pip install graphifyy`
- O plugin `.opencode/plugins/graphify.js` alerta antes de comandos bash quando o grafo existe
- `graphify update .` é AST-only (zero custo de API)
- **DuckDB backend** (`scripts/graphify-duck.py`) requer `pip install duckdb` — é opcional, mas recomendado para consultas SQL diretas e análise de impacto. O DuckDB abre em modo read-only para queries, evitando locks concorrentes no Windows.
