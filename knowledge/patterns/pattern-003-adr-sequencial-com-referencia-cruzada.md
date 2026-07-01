# Pattern 003 — ADR Sequencial com Referência Cruzada

## Problema

Decisões arquiteturais tomadas ao longo do tempo se perdem ou se contradizem quando não há um sistema de rastreamento. Alterar uma decisão sem referenciar a anterior cria inconsistência no registry — alguém lendo o ADR mais novo não sabe que existe um contexto anterior.

## Solução

Usar numeração sequencial para ADRs e sempre referenciar decisões anteriores quando uma nova decisão modifica, substitui ou complementa uma existente.

### Convenção de nomenclatura

```
knowledge/registry/adr-{NNN}-{titulo-kebab-case}.md
```

Exemplos:
- `adr-001-agents-md-como-veiculo-principal.md`
- `adr-002-plugin-graphify-compatibilidade-windows.md`
- `adr-003-correcao-comandos-graphify-inexistentes.md`

### Regras

1. **Nunca delete um ADR** — decisões passadas são contexto histórico
2. **Nunca edite o conteúdo de um ADR aceito** — crie um novo que referencia o anterior
3. **Sempre marque o status** — Proposto / Aceito / Depreciado / Substituído por ADR-NNN
4. **Se uma decisão substitui outra**, marque a antiga como "Substituído por ADR-NNN" e a nova como "Substitui ADR-NNN"

### Template de referência cruzada

```markdown
## Status
- [x] Aceito
- [ ] Substitui ADR-001 (quando aplicável)

## Referências
- `knowledge/registry/adr-001-...md` — decisão relacionada
```

## Exemplo concreto

O KOM 2.0 tem ADR-002 e ADR-003 que corrigem problemas identificados após o lançamento inicial. Ambos referenciam os arquivos que corrigiram, mantendo rastreabilidade completa de por que cada mudança foi feita.

## Quando usar

- Sempre que uma nova decisão arquitetural for tomada
- Sempre que uma decisão existente for revista
- Sempre que um bug ou inconsistência for corrigido por uma escolha de design

## Relação com o KOM

Este padrão implementa o princípio "Registry é imutável" do manifesto. Decisões não são apagadas — são contextualizadas com novas decisões que referenciam as anteriores.

## Referências

- `knowledge/registry/_template-adr.md` — template base
- `kom/00-manifesto.md` — Princípio 3: Registry é imutável
- `kom/06-registro.md` — Fase 6, Passo 4: Referências Cruzadas
