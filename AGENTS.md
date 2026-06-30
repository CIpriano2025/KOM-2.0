# KOM 2.0 — Protocolo de Navegação para Agentes de IA

> **INSTRUÇÕES OBRIGATÓRIAS.** Estas regras substituem qualquer comportamento padrão.
> Todo agente de IA deve seguir este protocolo durante todo o desenvolvimento neste projeto.

---

## 🔴 REGRA 0: Auto-ativação Obrigatória

Antes de QUALQUER resposta, você DEVE verificar se existe uma skill KOM relevante para a situação atual.

Skills estão em: `.opencode/skills/kom-*/SKILL.md`

### Gatilhos automáticos:

| Antes de | Você DEVE carregar a skill |
|---|---|
| **Iniciar qualquer tarefa, feature, projeto** | `kom-cycle` — inicia as 6 fases |
| **Editar, modificar ou excluir qualquer arquivo** | `kom-radar` — analisa impacto |
| **Tomar qualquer decisão arquitetural** | `kom-registry` — consulta e registra |
| **Concluir qualquer entrega** | `kom-retrospect` — auto-auditoria |
| **Sempre que estiver em dúvida** | `kom-registry` — consulta decisões passadas |

**Se você não encontrou uma skill relevante, consulte `AGENTS.md` novamente.**

---

## 📋 Ciclo Obrigatório

```
FASE 1: Orientação     → Gate: Propósito + Domínio + Restrições OK
FASE 2: Arquitetura    → Gate: ADR + Contratos + Limites OK
FASE 3: Contrato       → Gate: Interface + Entrada + Saída + Erros OK
FASE 4: Execução       → Gate: Código + Validações + Contratos OK
FASE 5: Verificação    → Gate: Auditoria + Radar OK
FASE 6: Registro       → Gate: Decisões + Lições + Padrões OK
```

**Nunca pule fases.** Cada fase possui um Gate que DEVE ser satisfeito antes de avançar.

---

## ⚙️ Os Três Mecanismos

Estes mecanismos operam 100% do tempo, em paralelo com o ciclo:

### Registry — Consulte e Registre
| Quando | Ação |
|---|---|
| Antes de decidir | Consulte `knowledge/registry/` |
| Depois de decidir | Registre em `knowledge/registry/` |
| Ao encontrar dúvida | Consulte antes de inventar |

### Radar — Analise Antes de Alterar
```
1. O que este arquivo faz?
2. Quem importa ou depende dele?
3. O que pode quebrar com esta mudança?
4. Quais contratos estão envolvidos?
5. Existe decisão no Registry que afeta esta área?
```

### Retrospect — Aprenda com Cada Entrega
```
1. O que eu faria diferente?
2. Alguma decisão foi subótima? Por quê?
3. Algum padrão útil emergiu?
4. O que deu errado que poderia ter sido evitado?
5. O que devo registrar para o futuro?
```
Registre as respostas em `knowledge/lessons/`.

---

## 📜 Regras de Conduta

### 1. Conhecimento antes do código
Nunca escreva código antes de ter clareza sobre Propósito, Domínio e Restrições.

### 2. Contrato antes da implementação
Nenhuma função, módulo ou API sem especificar Interface, Entrada, Saída, Erros e Impacto.

### 3. Radar antes da edição
Para cada arquivo a modificar, execute o Radar. Se revelar riscos, documente antes de prosseguir.

### 4. Toda entrega gera registro
Decisões → `knowledge/registry/`. Lições → `knowledge/lessons/`. Padrões → `knowledge/patterns/`.

### 5. Auto-auditoria obrigatória
Antes de considerar concluído, faça a Retrospect. Corrija antes de entregar.

---

## ⚡ Gatilhos Rápidos

| Situação | Ação |
|---|---|
| Início de sessão | Carregue skills KOM + Consulte Registry + Lessons |
| Nova tarefa | Skill `kom-cycle` + Fase 1 (Orientação) |
| Alterar arquivo existente | Skill `kom-radar` |
| Dúvida arquitetural | Skill `kom-registry` |
| Concluir entrega | Skill `kom-retrospect` + Fase 6 (Registro) |
| Erro repetido | Consulte `knowledge/lessons/` |
| Fim de sessão | Registre checkpoint em `knowledge/session-checkpoint.md` |

---

## 🔄 Loop Engineering Mode

Para tarefas complexas, o ciclo KOM opera em **Loop Mode** com controles adicionais.

### Quando ativar

| Cenário | Modo |
|---|---|
| Tarefa simples (< 3 arquivos, sem estado compartilhado) | **Single-pass** (ciclo normal) |
| Feature complexa (5+ arquivos, múltiplas camadas) | **Loop mode** ativado |
| Bugfix em produção | Loop mode com `max_iterations=3` |
| Refactoring crítico | Loop mode com verificação externa obrigatória |

### Regras do Loop

**1. Sub-agent Separation**
O sub-agente que EXECUTA (Fases 1-4) não verifica. A verificação (Gate da Fase 5) é delegada a um sub-agente independente invocado via `task` com `subagent_type: "general"`.

**2. Ralph Technique**
Se o Gate falhar > 2x na mesma iteração:
1. PARE — não corrija no contexto atual
2. DESCARTE — o contexto está contaminado
3. RE-LEIA — apenas o Contrato (Fase 3)
4. RE-EXECUTE — Fase 4 em contexto limpo
5. VERIFIQUE — novo Gate com verificador independente

**3. Goal Conditions**
Cada Gate é uma condição de parada verificável. Documente o Goal como:

```
goal: "todos os testes em tests/auth passam + lint limpo"
```

**4. Circuit Breakers**
- `max_iterations`: 5 (default), 10 (máximo absoluto)
- `token_budget`: 200K por iteração
- `timeout`: 30min por fase
- Se excedido: PARE, registre em `knowledge/lessons/`, escale para humano

**5. Cost Controls por Tipo**

| Tipo | max_iterations | token_budget | timeout |
|---|---|---|---|
| Pequeno | 3 | 100K | 15min |
| Médio | 5 | 200K | 30min |
| Grande | 7 | 400K | 60min |
| Crítico | 10 | 1M | 2h |

Consulte `kom/08-loop-engineering.md` para o protocolo completo.

---

## ⚠️ Violações

Se você identificou que pulou uma fase:

1. **PARE IMEDIATAMENTE**
2. Volte para a fase omitida
3. Complete a fase corretamente
4. Registre a violação em `knowledge/lessons/`
5. Só então prossiga

**Violações não são para ser escondidas — são para ser aprendidas.**

---

> 💡 **KOM 2.0** não é um conjunto de regras para seguir cegamente.
> É um protocolo de navegação para evitar que a IA se perca.
> Se você está prestes a pular uma regra, pergunte-se:
> *"Estou pulando porque é desnecessário ou porque é mais fácil?"*
> Se for mais fácil, **não pule.**
