# Pattern 002 — Separador Universal de Comandos Shell

## Problema

Concatenar comandos shell usando `&&` funciona em bash (Linux/Mac) mas falha no PowerShell 5.1 (Windows) com `ParserError: InvalidEndOfLine`. Projetos que suportam múltiplos SOs precisam de um separador compatível com ambos.

## Solução

Usar `;` como separador de comandos em vez de `&&` quando o segundo comando **nunca falha** ou quando a execução do segundo não depende do sucesso do primeiro.

```bash
# ❌ Falha no PowerShell 5.1
echo "aviso" && comando_real

# ✅ Funciona em bash e PowerShell
echo "aviso" ; comando_real
```

## Quando `;` é equivalente a `&&`

Quando o primeiro comando é um `echo` (que nunca falha), `;` e `&&` produzem o mesmo resultado. O `echo` sempre retorna exit code 0, portanto `&&` sempre executaria o segundo comando de qualquer forma.

## Quando NÃO usar `;` no lugar de `&&`

Quando a execução do segundo comando **depende** do sucesso do primeiro:

```bash
# Não substituir por ; — o segundo só deve rodar se o primeiro passar
npm install && npm run build
```

Neste caso, mantenha `&&` e documente que o script requer bash ou PowerShell 7+.

## Exemplo concreto

O plugin `.opencode/plugins/graphify.js` usava `&&` para concatenar um `echo` de aviso com o comando do usuário. Substituído por `;` para compatibilidade com PowerShell 5.1 no Windows (ver ADR-002).

## Quando usar

- Qualquer script que rode em Windows e Linux/Mac
- Plugins e ferramentas de IDE que injetam comandos shell
- Scripts de onboarding e verificação (como `kom-check.ps1`)

## Referências

- `knowledge/registry/adr-002-plugin-graphify-compatibilidade-windows.md`
- `.opencode/plugins/graphify.js`
