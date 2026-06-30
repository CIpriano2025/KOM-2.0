# Fase 4 — Execução

> **Implemente com propósito.** Cada linha de código deve satisfazer um contrato. Nada mais. Nada menos.

---

## Propósito

Escrever código que satisfaz contratos, dentro dos limites da Arquitetura, respeitando o propósito da Orientação.

Execução não é "escrever código". É **escrever código que prova que o contrato está certo**.

---

## Gatilho

Esta fase inicia após o Contrato ser aprovado (gate aprovado).

---

## Protocolo

### Passo 1: Prepare a Validação Primeiro
- Para cada contrato, crie uma verificação que comprove seu cumprimento
- A verificação deve **falhar** antes da implementação existir
- Isso prova que a verificação funciona

### Passo 2: Implemente o Mínimo Necessário
- Apenas o código necessário para satisfazer o contrato
- Nada além. Nem uma linha.
- Se não é necessário agora, não escreva

### Passo 3: Valide Contra o Contrato
- Execute a verificação (teste, type check, validação)
- Confirme que cada ponto do contrato é satisfeito
- Se falhar: ajuste a implementação (nunca o contrato sem voltar à Fase 3)

### Passo 4: Execute o Radar
- O código novo quebra algo existente?
- Alguém depende do que foi alterado?
- Existem efeitos colaterais não previstos?

### Passo 5: Corrija Descobertas
- Se o Radar ou validação revelarem problemas, corrija
- Se a correção exigir mudança no contrato, **volte à Fase 3**

---

## Gate de Saída

- [ ] Cada contrato tem verificação (teste/validação)
- [ ] Implementação satisfaz todos os pontos do contrato
- [ ] Radar executado sobre código novo e alterado
- [ ] Nada implementado além do necessário
- [ ] Nada existente foi quebrado (verificado)

---

## Anti-Padrões

| Comportamento | Risco |
|---|---|
| "Vou escrever um pouco mais, já vai precisar" | O que não é necessário hoje será julgado errado amanhã. |
| "Validar depois da implementação" | Validação depois confirma o que fez, não o que deveria fazer. |
| "Só mais um ajuste" | Cada ajuste não planejado viola o contrato. |
| Ignorar o Radar | Código novo pode quebrar o que você não está vendo. |
| "Funciona na minha máquina" | Não é critério. O contrato é o critério. |

---

## Radar Check

- [ ] Registry consultado para padrões de implementação?
- [ ] Impacto em áreas vizinhas mapeado?
- [ ] Verificações existentes ainda passam?
