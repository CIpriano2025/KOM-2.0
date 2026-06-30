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
