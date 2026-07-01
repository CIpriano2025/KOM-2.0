# ADR-003 — Correção de comandos Graphify inexistentes

## Contexto

Durante auditoria fresh-eye do KOM 2.0, identificou-se que o comando `graphify affected` é referenciado em 4 arquivos do projeto, mas não existe no graphify real. Os comandos reais são: `query`, `path`, `explain`, `update`, `.` (build). Isso causa confusão em usuários que tentam usar o comando e recebem erro.

Além disso:
- `08-loop-engineering.md` se autodenominava "Fase 8", contradizendo o ciclo de 6 fases
- `knowledge/lessons/` e `knowledge/patterns/` eram referenciados mas não existiam como diretórios
- `kom-graphify` não aparecia na tabela de gatilhos automáticos do `AGENTS.md`
- A árvore do `README.md` omitia `kom-graphify` e `kom-loop`

## Decisão

Substituir todas as ocorrências de `graphify affected` por `graphify query` com perguntas semanticamente equivalentes. Corrigir demais inconsistências.

**Opção escolhida:** Substituição direta por `graphify query`

## Consequências

### Positivas
- Usuários não encontrarão mais comandos que não existem
- Consistência entre documentação e ferramenta real
- `kom-graphify` agora é visível nos gatilhos automáticos

### Negativas
- `graphify query "impacto de X"` depende da qualidade da LLM usada pelo graphify, não é uma função dedicada de impacto

## Alternativas Consideradas

### Alternativa A: Contribuir com `graphify affected` como nova feature no graphify
- **Motivo da rejeição:** Depende de terceiros; não resolve o problema hoje

### Alternativa B: Manter como está e documentar como "comando futuro"
- **Motivo da rejeição:** Quebra a confiança do usuário na documentação

## Status

- [x] Aceito
- [x] Implementado

## Referências

- `.opencode/skills/kom-graphify/SKILL.md`
- `kom/02-arquitetura.md`
- `kom/05-verificacao.md`
- `kom/08-loop-engineering.md`
- `AGENTS.md`
- `README.md`
