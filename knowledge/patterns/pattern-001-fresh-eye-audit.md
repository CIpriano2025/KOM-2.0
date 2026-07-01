# Pattern 001 — Fresh-Eye Audit

## Problema

Após construir ou modificar documentação, o autor desenvolve cegueira para inconsistências. Comandos que não existem, referências cruzadas quebradas, numerações erradas e diretórios referenciados mas não criados passam despercebidos porque o contexto de criação contamina a revisão.

## Solução

Antes de qualquer entrega pública (commit, PR, release), realizar uma auditoria com "olhar de primeira vez":

1. Feche todo o contexto de criação (nova sessão ou sub-agente independente)
2. Leia cada arquivo como se fosse um usuário chegando pela primeira vez
3. Execute todos os comandos documentados — se um comando falhar, ele está errado
4. Verifique se cada diretório referenciado existe de fato
5. Verifique consistência de numerações, títulos e referências cruzadas
6. Registre cada inconsistência encontrada como ADR ou Lesson

## Exemplo concreto

Durante a construção do KOM 2.0, o comando `graphify affected` foi documentado em 4 arquivos sem verificar se existia. Uma fresh-eye audit revelou que o comando real é `graphify query`. Todos os 4 arquivos foram corrigidos (ver ADR-003).

## Quando usar

- Antes de qualquer commit em repositório público
- Antes de lançar documentação para usuários externos
- Após qualquer refatoração de documentação
- Sempre que um usuário reportar que um comando "não funciona"

## Quando não usar

- Durante a fase de criação (não interrompa o fluxo criativo com auditoria)
- Para revisões internas rápidas onde o contexto ainda está fresco e é útil

## Relação com o KOM

Este padrão é uma especialização da Fase 5 (Verificação) para projetos de documentação. Incorporar como etapa obrigatória no Gate da Fase 5 quando a entrega incluir documentação pública.

## Referências

- `knowledge/lessons/2026-06-30-correcao-inconsistencias-documentacao.md`
- `knowledge/registry/adr-003-correcao-comandos-graphify-inexistentes.md`
