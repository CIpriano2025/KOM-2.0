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

## Gate de Saída

- [ ] Auto-auditoria realizada (código revisado com olhar crítico)
- [ ] Conformidade com contratos confirmada
- [ ] Conformidade arquitetural confirmada
- [ ] Radar executado sobre todos os arquivos alterados
- [ ] Problemas encontrados foram corrigidos ou documentados

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
