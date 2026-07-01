# Loop Engineering

> **Loop Engineering é a evolução do Vibe Coding.** Em vez de prompts manuais um a um, você projeta um sistema autônomo que itera até o Goal ser atingido.

---

## Contexto

| Marco | Quem | Quando |
|---|---|---|
| "Vibe Coding" cunhado | Andrej Karpathy | Fev 2025 |
| Vibe Coding declarado "morto" | Karpathy (Sequoia AI Ascent) | Abr 2026 |
| **Loop Engineering** popularizado | Addy Osmani, Peter Steinberger, Boris Cherny | Jun 2026 |
| KOM 2.0 + Loop Engineering | Este documento | 2026 |

Loop Engineering substitui **Prompt Engineering** como paradigma dominante:

| Prompt Engineering | Loop Engineering |
|---|---|
| Prompt único → resposta única | Ciclo: gerar → executar → observar → realimentar |
| Humano digita cada prompt | Humano arquiteta o sistema de ciclos |
| Contexto morre com a resposta | Memória persiste em arquivos (knowledge/) |
| Frágil em tarefas longas | Robusto para fluxos multi-passo |

---

## 🔄 ReAct no KOM 2.0

O padrão **ReAct** (Reason + Act) mapeia diretamente para o ciclo KOM:

| Fase KOM | ReAct | Descrição |
|---|---|---|
| Orientação | Reason | Raciocinar sobre propósito e restrições |
| Arquitetura | Reason + Act | Decidir estrutura, registrar ADR |
| Contrato | Reason | Definir interfaces, entradas, saídas, erros |
| Execução | Act | Implementar conforme o contrato |
| Verificação | Observe | Observar resultado, comparar com contrato |
| Registro | Reason | Raciocinar sobre o que foi aprendido |

Cada ciclo completo = uma iteração ReAct.

---

## ⚡ Sub-Agent Separation

**Regra fundamental:** O sub-agente que EXECUTA não VERIFICA.

### Por quê

Um agente que acabou de escrever código tem viés de confirmação. Ele:
- Defende as próprias escolhas
- Subestima bugs que introduziu
- Aceita "funciona" como "está correto"

### Como implementar

```
Fases 1-4 (Executor)
        │
        ▼
    [Gate] ── Verificado por SUB-AGENTE INDEPENDENTE
        │
   Aprovado? ──Sim──> Fase 6 (Registro)
        │
       Não
        │
        ▼
    Ralph Technique (contexto fresco)
```

Para invocar o verificador independente:

> Invoque `task` com `subagent_type: "general"` passando apenas o Contrato (Fase 3) e o código produzido. O verificador não deve ter acesso ao contexto da execução.

---

## 🌀 Ralph Technique

Quando a verificação falha, **não tente corrigir no mesmo contexto**.

O contexto atual está contaminado por:
- Decisões incorretas já tomadas
- Raciocínio que levou ao erro
- Cansaço cognitivo do agente

### Protocolo

1. **PARE** — não faça mais nada no contexto atual
2. **PRESERVE** — o Contrato (Fase 3) não muda
3. **RESET** — descarte todo o contexto da iteração anterior
4. **RE-EXECUTE** — leia apenas o Contrato, reimplemente do zero
5. **VERIFIQUE** — novo Gate com verificador independente

```
Iteração 1: contexto_A ──> código_A ──> Gate FAIL ⨯
                  │
                  │  (descarta contexto_A)
                  ▼
Iteração 2: contexto_B ──> código_B ──> Gate OK ✓
                  │
                  ▼
            Fase 6 (Registro)
```

### Limites

| Parâmetro | Default | Máximo |
|---|---|---|
| max_iterations | 5 | 10 |
| token_budget | 200K por iteração | 1M total |
| timeout | 30min por fase | 2h total |

Após exceder `max_iterations`, o ciclo deve:
1. Escalar para revisão humana
2. Registrar em `knowledge/lessons/` como "loop exausted"
3. Não continuar tentando

---

## 🎯 Goal Conditions

Cada Gate do KOM 2.0 é uma **Goal Condition** — condição de parada verificável.

| Gate | Condição | Verificador |
|---|---|---|
| Orientação | Propósito + Domínio + Restrições documentados | Auto-check |
| Arquitetura | ADR registrado + Contratos + Limites OK | Registry check |
| Contrato | Interface + Entrada + Saída + Erros definidos | Sub-agente |
| Execução | Código + Validações + Contratos OK | Testes automatizados |
| Verificação | Auditoria + Radar OK | Sub-agente independente |
| Registro | Decisões + Lições + Padrões persistidos | Auto-check |

### Goal formal

Para tarefas complexas, defina a Goal Condition como um arquivo `goal.md`:

```yaml
goal:
  description: "Implementar autenticação JWT"
  files: ["src/auth/*", "tests/auth/*"]
  tests: ["npm run test:auth"]
  lint: true
  typecheck: true
  max_iterations: 3
```

O verificador independente usa este arquivo para validar objetivamente.

---

## 🔁 Loop Cadence

O ciclo KOM pode re-triggerar automaticamente:

| Trigger | Quando | Ação |
|---|---|---|
| PR merged | Código novo em main | Ciclo de verificação pós-merge |
| Schedule (daily) | Todo início de dia | Ciclo de manutenção |
| Error threshold | N bugs em N dias | Ciclo de correção |
| Dependency update | Dependência alterada | Ciclo de atualização |
| Manual | Solicitação humana | Ciclo completo |

---

## ⛔ Circuit Breakers

Proteções contra loops runaway:

```
┌──────────────────────────────────────────────┐
│ Circuit Breaker                              │
│                                              │
│ max_iterations: 5    ●○○○○○                  │
│ token_budget: 200K   ████████░░ 80%          │
│ timeout: 30min       ████████░░              │
│                                              │
│ ⚠️ Se QUALQUER limite for excedido:          │
│   1. PARE imediatamente                       │
│   2. Registre em knowledge/lessons/           │
│   3. Escale para humano                       │
└──────────────────────────────────────────────┘
```

---

## 💰 Cost Controls

| Tipo de Projeto | max_iterations | token_budget | timeout |
|---|---|---|---|
| Pequeno (< 3 arquivos) | 3 | 100K | 15min |
| Médio (3-10 arquivos) | 5 | 200K | 30min |
| Grande (10+ arquivos) | 7 | 400K | 60min |
| Crítico (produção) | 10 | 1M | 2h |

Registre o custo real de cada ciclo em `knowledge/lessons/costs.md`.

---

## 🌲 Worktree Isolation (Opcional)

Para iterações da Ralph technique, use git worktrees:

```bash
git worktree add ../kom-iter-1 kom-iter-1
# trabalha em ../kom-iter-1
git worktree remove ../kom-iter-1
```

Cada iteração em worktree isolado. Sem risco de contaminação entre iterações.

---

## 📋 Checklist do Loop

- [ ] Modo definido: single-pass ou loop?
- [ ] Se loop: max_iterations e token_budget configurados?
- [ ] Verificador independente designado?
- [ ] Goal condition documentada?
- [ ] Circuit breakers ativos?
- [ ] Ralph technique compreendida (saber quando resetar)?

---

## Anti-Padrões

| Comportamento | Risco |
|---|---|
| "Só mais uma tentativa no mesmo contexto" | Viés de confirmação acumulando |
| "O código está quase certo" | Quase certo = errado. Reset e tente de novo. |
| "Deixa que eu mesmo verifico" | Sub-agent separation não é opcional |
| "Só mais 5 minutos" | Limites existem por uma razão. Respeite. |
| Ignorar circuit breakers | Runaway token bill. Você foi avisado. |
| Ralph technique sem worktree | Contexto contaminado. A técnica não funciona. |
