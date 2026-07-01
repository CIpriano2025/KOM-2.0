# Fase 5 — Verificação

> **Audite antes de entregar.** O momento mais barato para corrigir um erro é agora.

---

## Propósito

Antes de considerar o trabalho concluído, o agente deve auditar a própria entrega. Verificação é o filtro crítico que separa "funciona" de "está pronto para produção".

---

## Gatilho

Esta fase inicia após a Execução ser concluída (gate aprovado).

---

## Protocolo

### Passo 1: Audite com Olhar Crítico
- Se você encontrasse este código como outro desenvolvedor, o que criticaria?
- Existem nomes ruins, abstrações prematuras, complexidade desnecessária?
- O código está no lugar certo?

### Passo 2: Verifique Conformidade com Contratos
- Releia cada contrato da Fase 3
- A implementação satisfaz cada ponto?
- Existem comportamentos não especificados (side effects)?

### Passo 3: Verifique Conformidade Arquitetural
- A implementação respeita os limites definidos na Fase 2?
- As dependências estão na direção correta?
- Não foram introduzidas violações arquiteturais?

### Passo 4: Execute o Radar Completo
Para cada arquivo alterado:
- O que ele faz?
- Quem importa dele?
- O que pode quebrar?

### Passo 5: Corrija Problemas
- Nesta fase, você pode e deve corrigir
- Correção não precisa de novo Contrato (a menos que mude interface)
- Se mudar a interface, **volte à Fase 3**

---

## 🔄 External Verification (Loop Engineering)

### Regra Fundamental

O sub-agente que executou as Fases 1-4 está contaminado — tem viés de confirmação sobre o próprio código e decisões.

A verificação DEVE ser feita por uma **entidade independente**:
- **Opção A (recomendada):** Sub-agente invocado via `task` com `subagent_type: "general"`, recebendo apenas o Contrato (Fase 3) e o código produzido
- **Opção B:** Instância limpa do agente (nova sessão, mesmo diretório, apenas o contrato como input)
- **Opção C:** Revisão humana (code review)

### Ralph Gate

Se a verificação falhar:
1. **NÃO** tente corrigir no mesmo contexto (viés de confirmação)
2. Invoque a **Ralph technique** (ver `kom/08-loop-engineering.md`)
3. O novo ciclo lê APENAS o Contrato da Fase 3, não o código anterior
4. Re-executa em contexto limpo

### Automated Pre-Checks

Antes da verificação por sub-agente independente, execute:
- [ ] Testes automatizados (unitários, integração)
- [ ] Lint / type-check / análise estática
- [ ] Verificação de contrato (entrada/saída/erros batem com a Fase 3?)
- [ ] Varredura de segurança básica
- [ ] `graphify query "dependências de {arquivo}"` — análise de impacto colateral
- [ ] `graphify query "quebras potenciais"` — verificar dependências não consideradas

---

## Gate de Saída

- [ ] Auto-auditoria realizada (código revisado com olhar crítico)
- [ ] Conformidade com contratos confirmada
- [ ] Conformidade arquitetural confirmada
- [ ] Radar executado sobre todos os arquivos alterados
- [ ] Problemas encontrados foram corrigidos ou documentados
- [ ] **Contract Tests:** implementação valida contratos da Fase 3 (entrada/saída/erros)
- [ ] **Contract Tests:** testes automatizados comprovam conformidade com o contrato

---

## Anti-Padrões

| Comportamento | Risco |
|---|---|
| "Acabou, está funcionando" | Funcionar não é suficiente. Tem que ser sustentável. |
| "Isso é frescura, reviso depois" | Depois não revisa. Nunca. |
| "O Radar não encontrou nada" | Radar vazio não significa que não há nada. Revise manualmente. |
| "Só ignorei um detalhe" | Detalhes viram bugs de produção. |
| Pular auditoria por pressa | Pressa é quando você mais precisa de verificação. |

---

## Radar Check

- [ ] Registry consultado para verificar impacto?
- [ ] Lessons consultadas para erros conhecidos?
- [ ] Patterns consultados para conformidade?
