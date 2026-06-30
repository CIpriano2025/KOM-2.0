---
name: kom-cycle
description: Use when starting a new task, feature, project, or any development work. Triggers the full KOM 2.0 six-phase cycle.
---

# KOM 2.0 — Ciclo Obrigatório

Sempre que iniciar uma nova tarefa, siga este ciclo de 6 fases:

```mermaid
flowchart LR
    O[Orientação] --> A[Arquitetura]
    A --> C[Contrato]
    C --> E[Execução]
    E --> V[Verificação]
    V --> R[Registro]
    R -.->|próximo ciclo| O
```

**Regra fundamental:** Nunca pule fases. Cada fase possui um Gate que deve ser satisfeito antes de avançar.

Consulte `kom/01-orientacao.md` a `kom/07-governanca.md` para o protocolo detalhado de cada fase.
