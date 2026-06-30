# Fase 3 — Contrato

> **Especifique antes de implementar.** Um contrato bem escrito torna impossível implementar a coisa errada.

---

## Propósito

Antes de implementar qualquer função, módulo ou API, especifique **exatamente** o que está sendo construído. O Contrato é o pacto entre intenção e implementação.

---

## Gatilho

Esta fase inicia após a Arquitetura ser concluída (gate aprovado). Aplica-se a cada unidade implementável: função, componente, endpoint, módulo.

---

## Protocolo

### Passo 1: Defina a Interface

```
Nome:           [identificador único]
Assinatura:     [parâmetros, tipo de retorno]
Pré-condições:  [o que deve ser verdade antes de chamar]
Pós-condições:  [o que será verdade depois de chamar]
```

### Passo 2: Especifique a Entrada

- Tipos aceitos
- Formato esperado
- Valores válidos e inválidos
- Limites (tamanho, intervalo, cardinalidade)

### Passo 3: Especifique a Saída

- Tipos retornados
- Formato da resposta
- Sucesso: o que retorna
- Bordas: o que retorna em cada cenário

### Passo 4: Especifique os Erros

- O que pode falhar
- Como a falha é reportada (exceção, código, retorno)
- O que o chamador deve fazer em cada falha

### Passo 5: Mapeie o Impacto

- O que mais no sistema depende desta unidade?
- Quais contratos são afetados?
- Quais verificações existentes precisam mudar?

---

## Gate de Saída

- [ ] Interface (nome + assinatura + pre/pós-condições)
- [ ] Entrada (tipos, formato, limites)
- [ ] Saída (tipos, formato, cada cenário)
- [ ] Erros (falhas possíveis, reporte, ação do chamador)
- [ ] Impacto (dependências, contratos afetados)

---

## Anti-Padrões

| Comportamento | Risco |
|---|---|
| "O código é autoexplicativo" | Código diz o que faz, não o que deveria. |
| "Vou documentar depois" | Documentação pós-implementação sempre incompleta. |
| "Isso é óbvio" | Óbvio para você não é para o agente da próxima sessão. |
| Esquecer o impacto | Um contrato pode quebrar quem você não viu. |
| Contrato prolixo | Prefira preciso a detalhado. Uma linha exata > um parágrafo vago. |

---

## Radar Check

- [ ] Registry consultado para contratos similares?
- [ ] Impacto em outros contratos mapeado?
- [ ] Dependências de verificação identificadas?
