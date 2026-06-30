# Fase 1 — Orientação

> **Entenda antes de fazer.** Toda grande falha de engenharia começa com uma pergunta que não foi feita.

---

## Propósito

Antes de qualquer linha de código, o agente precisa entender **o que** está sendo construído, **por que** está sendo construído e **dentro de quais limites**.

---

## Gatilho

Esta fase inicia quando:
- Uma nova tarefa é solicitada
- Um novo projeto ou feature começa
- Um requisito muda significativamente

---

## Protocolo

### Passo 1: Identifique o Propósito
- Qual problema está sendo resolvido?
- Quem é o usuário final?
- Qual o critério de sucesso?

### Passo 2: Mapeie o Domínio
- Quais conceitos estão envolvidos?
- Qual a terminologia?
- Existem regras de negócio conhecidas?

### Passo 3: Liste as Restrições
- **Técnicas**: linguagem, infraestrutura, performance
- **Negócio**: orçamento, prazo, compliance
- **Equipe**: quem mantém, quem conhece o domínio

### Passo 4: Consulte o Registry
- Existem decisões anteriores que afetam esta área?
- Existem lições em `knowledge/lessons/`?
- Existem padrões em `knowledge/patterns/`?

### Passo 5: Documente
- Escreva um documento de orientação claro e objetivo
- Inclua: propósito, domínio, restrições, referências

---

## Gate de Saída

- [ ] Propósito claro (o problema, não a solução)
- [ ] Domínio mapeado (conceitos, terminologia, regras)
- [ ] Restrições listadas (técnicas, negócio, equipe)
- [ ] Registry consultado (decisões existentes revisadas)

---

## Anti-Padrões

| Comportamento | Risco |
|---|---|
| "Já sei o que precisa ser feito" | Viés de confirmação. Pergunte antes. |
| "Vou descobrir enquanto codifico" | Descoberta tardia gera retrabalho caro. |
| "Isso é igual ao projeto X" | Projetos parecidos têm limites diferentes. |
| "O usuário pediu X, então é X" | O que pedem raramente é o que precisam. |
| Pular consulta ao Registry | Decisões passadas serão contraditas. |

---

## Radar Check

- [ ] Registry consultado?
- [ ] Lessons consultadas?
- [ ] Patterns consultados?
