# Fase 6 — Registro

> **Se não foi registrado, não aconteceu.** O conhecimento não morre com o fim da sessão — ele se acumula.

---

## Propósito

Persistir o conhecimento gerado durante o ciclo. Cada fase produziu descobertas, decisões e lições. O Registro é o que diferencia KOM 2.0 de metodologias convencionais — o conhecimento se acumula, não se perde.

---

## Gatilho

Esta fase inicia após a Verificação ser concluída (gate aprovado).

---

## Protocolo

### Passo 1: Registry — Decisões Arquiteturais
Em `knowledge/registry/`, crie um novo arquivo com:

```
Nome:      [decisão-nome]
Contexto:  [por que foi necessária]
Decisão:   [o que foi decidido]
Alternativas: [o que foi descartado e por quê]
Motivo:    [por que esta opção venceu]
Impacto:   [o que muda com esta decisão]
```

### Passo 2: Lessons — Lições Aprendidas
Em `knowledge/lessons/`, registre a Retrospectiva:

```
1. O que eu faria diferente?
2. Alguma decisão foi subótima? Por quê?
3. Algum padrão útil emergiu?
4. O que deu errado e poderia ter sido evitado?
5. O que devo registrar para o futuro?
```

### Passo 3: Patterns — Padrões Identificados
Em `knowledge/patterns/`, se um padrão útil foi descoberto:
- Descreva o problema que ele resolve
- Dê um exemplo concreto
- Quando usar e quando evitar

### Passo 4: Referências Cruzadas
- Se este registro afeta decisões anteriores, referencie-as
- Não altere decisões passadas — adicione novas que referenciam as antigas

---

## Gate de Saída

- [ ] Toda decisão arquitetural registrada em `knowledge/registry/`
- [ ] Retrospectiva realizada e registrada em `knowledge/lessons/`
- [ ] Padrões identificados registrados em `knowledge/patterns/`
- [ ] Referências cruzadas entre decisões atualizadas

---

## Anti-Padrões

| Comportamento | Risco |
|---|---|
| "Vou registrar depois" | Depois os detalhes se perdem. Registre agora. |
| "Só a decisão, sem contexto" | Decisão sem contexto é inútil para consultas futuras. |
| "Já está no código" | Código diz o que, não por quê. |
| Registro prolixo | Seja completo, não prolixo. Prefira objetivo. |
| Ignorar Lessons | Se você não aprendeu nada, não prestou atenção. |

---

## Radar Check

- [ ] Registry anterior consultado para consistência?
- [ ] Todas as decisões têm contexto e alternativas?
- [ ] As lições são acionáveis (não genéricas)?
