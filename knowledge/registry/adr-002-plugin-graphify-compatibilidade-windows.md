# ADR-002 — Correção de compatibilidade do plugin Graphify no Windows

## Contexto

O plugin `.opencode/plugins/graphify.js` usa `&&` para concatenar um comando `echo` de aviso com o comando bash original do usuário. No PowerShell 5.1 (Windows), `&&` não é um operador válido, causando `ParserError: InvalidEndOfLine` e travando qualquer comando bash no OpenCode.

## Decisão

Substituir `&&` por `;` como separador de comandos.

**Opção escolhida:** `;` (separador universal)

## Consequências

### Positivas
- Funciona no PowerShell 5.1 (Windows)
- Funciona no bash (Linux/Mac) — `;` é compatível em ambos
- Zero perda de funcionalidade: echo nunca falha, então `&&` e `;` são equivalentes na prática

### Negativas
- Nenhuma

## Alternativas Consideradas

### Alternativa A: Manter `&&` e documentar como limitação
- **Motivo da rejeição:** Quebra a ferramenta no Windows sem necessidade

### Alternativa B: Detectar SO e escolher separador
- **Motivo da rejeição:** Complexidade desnecessária para um caso que `;` resolve universalmente

## Status

- [x] Aceito
- [x] Implementado em `.opencode/plugins/graphify.js` linha 22

## Referências

- `.opencode/plugins/graphify.js:22`
