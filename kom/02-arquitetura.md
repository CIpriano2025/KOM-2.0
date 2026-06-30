# Fase 2 — Arquitetura

> **Decida antes de construir.** Arquitetura é sobre limites e contratos, não sobre diagramas bonitos.

---

## Propósito

Definir a estrutura do sistema antes de implementá-lo. Arquitetura são as **decisões que não podem ser mudadas depois sem custo alto**.

---

## Gatilho

Esta fase inicia após a Orientação ser concluída (gate aprovado).

---

## Protocolo

### Passo 1: Identifique os Limites
- Onde termina seu sistema e começa o mundo externo?
- Quais são os pontos de integração?
- Quais são as fronteiras entre módulos internos?

### Passo 2: Defina Contratos de Fronteira
Para cada ponto de integração:
- Formato de dados
- Protocolo de comunicação
- Garantias (disponibilidade, consistência, latência)

### Passo 3: Tome Decisões Arquiteturais
Para cada decisão significativa:
- Documente o contexto
- Liste alternativas consideradas
- Explique o motivo da escolha
- Registre no Registry (`knowledge/registry/`)

### Passo 4: Identifique Riscos Técnicos
- O que pode dar errado?
- Quais suposições estamos fazendo?
- O que precisa ser validado cedo?

### Passo 5: Valide com o Radar
- As decisões impactam outras áreas?
- Existem dependências não consideradas?

---

## Gate de Saída

- [ ] Limites do sistema definidos
- [ ] Contratos de fronteira especificados
- [ ] Decisões arquiteturais registradas no Registry
- [ ] Riscos técnicos identificados
- [ ] Radar executado sobre as decisões

---

## Anti-Padrões

| Comportamento | Risco |
|---|---|
| "Arquitetura é detalhe, decido depois" | Decisões adiadas viram dívida arquitetural. |
| "Vamos usar X porque todo mundo usa" | Moda não é critério arquitetural. |
| "Uma decisão por dia" | Acumular decisões aumenta custo de mudança. |
| "Arquitetura é só tecnologia" | Arquitetura é limites e contratos, não bibliotecas. |
| Ignorar o Registry | Decisões anteriores podem contradizer a nova arquitetura. |

---

## Radar Check

- [ ] Registry consultado para decisões similares?
- [ ] Impacto em outras áreas mapeado?
- [ ] Dependências identificadas?
