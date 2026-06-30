---
name: kom-loop
description: Use when a task enters loop mode (complex features, Ralph technique, sub-agent verification, circuit breakers). Activates iterative execution controls.
---

# KOM 2.0 — Loop Controls

Ative este skill quando uma tarefa requer múltiplas iterações com contexto fresco.

---

## Gatilho

Este skill é ativado automaticamente quando:
- Feature complexa (5+ arquivos, múltiplas camadas)
- Gate da Fase 5 falhou e precisa de Ralph technique
- Sub-agent verification é necessária
- Circuit breakers precisam ser configurados

---

## Configuração do Loop

| Parâmetro | Default | Como alterar |
|---|---|---|
| `max_iterations` | 5 | Defina em `goal.md` ou use o default |
| `token_budget` | 200K por iteração | Ajuste por tipo de projeto |
| `timeout` | 30min por fase | Ajuste por tipo de projeto |

---

## Protocolo

### 1. Configurar
- Definir Goal Condition (critério de parada verificável)
- Configurar circuit breakers
- Designar verificador independente

### 2. Executar
- Rodar Fases 1-4 em contexto limpo
- Ao concluir, invocar verificador independente

### 3. Verificar
- Sub-agente verificador recebe: Contrato (Fase 3) + Código
- Verificador retorna: PASS ou FAIL + razão

### 4. Iterar ou Finalizar
- PASS → Fase 6 (Registro)
- FAIL + iterations < max → Ralph technique (contexto fresco)
- FAIL + iterations >= max → Escalar para humano

---

## Ralph Technique

"Mesmo contrato, nova instância, sem baggage."

```
1. PARE o contexto atual
2. PRESERVE o Contrato (Fase 3)
3. RESET para contexto limpo
4. RE-EXECUTE Fase 4
5. VERIFIQUE com sub-agente independente
```

Consulte `kom/08-loop-engineering.md` para o protocolo completo.
