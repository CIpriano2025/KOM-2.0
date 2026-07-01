# CORREÇÃO — KOM 2.0 Repositório Oficial

> Registro completo de todas as correções e adições aplicadas ao repositório oficial
> `https://github.com/CIpriano2025/KOM-2.0` em 30/06/2026.

---

## Resumo Executivo

Foram identificados e corrigidos **2 bugs** de texto/encoding, preenchidos **4 gaps** do próprio protocolo
(o projeto não seguia suas próprias regras em alguns pontos) e criado **1 documento de roadmap**
para separar o que existe hoje do que está planejado para o futuro.

---

## 1. Bug — Encoding corrompido em `kom/07-governanca.md`

### Problema

O diagrama mermaid do bloco "Tratamento de Violações" continha unicode escapes não decodificados.
Em qualquer renderizador (GitHub, VS Code, Obsidian), o diagrama exibia texto literal corrompido.

**Antes (quebrado):**
```
V[Violu00e7u00e3o detectada] --> P[Pare imediatamente]
P --> R[Volte u00e0 fase omitida]
R --> C[Complete a fase]
C --> L[Registre em lessons]
L --> S[Só entu00e3o prossiga]
```

**Depois (corrigido):**
```
V[Violação detectada] --> P[Pare imediatamente]
P --> R[Volte à fase omitida]
R --> C[Complete a fase]
C --> L[Registre em lessons]
L --> S[Só então prossiga]
```

### Causa raiz

`u00e7` = `ç`, `u00e3` = `ã`, `u00e0` = `à` — caracteres UTF-8 que foram salvos como unicode escapes
em vez de caracteres reais, provavelmente por um editor ou processo de serialização que não tratou
o encoding corretamente.

### Arquivo modificado

`kom/07-governanca.md`

---

## 2. Bug — Caracteres CJK em `kom/08-loop-engineering.md`

### Problema

O checklist do Loop Engineering continha caracteres japoneses/chineses `理解` inseridos por acidente
no meio de uma palavra portuguesa.

**Antes (quebrado):**
```
- [ ] Ralph technique理解ida (saber quando resetar)?
```

**Depois (corrigido):**
```
- [ ] Ralph technique compreendida (saber quando resetar)?
```

### Causa raiz

`理解` significa "compreender" em japonês/chinês. Provavelmente inserido por um IME (Input Method Editor)
ativo durante a edição ou por autocomplete de teclado que interferiu na digitação.

### Arquivo modificado

`kom/08-loop-engineering.md`

---

## 3. Gap — ADR-001 ausente no Registry

### Problema

O registry continha ADR-002 e ADR-003, mas o ADR-001 nunca havia sido criado.
A decisão mais fundamental do projeto — **por que usar AGENTS.md como veículo principal** —
não estava documentada, violando o próprio princípio do manifesto:

> *"Registry é imutável — decisões registradas não são apagadas."*

Se a decisão mais importante não foi registrada, o registry começa do zero sem contexto.

### Solução

Criado `knowledge/registry/adr-001-agents-md-como-veiculo-principal.md` documentando:

- **Contexto:** necessidade de entregar instruções a qualquer agente sem instalação
- **Decisão:** usar AGENTS.md (padrão Linux Foundation, 28+ ferramentas, 60k+ repos)
- **Alternativas descartadas:**
  - SDK/biblioteca — viola independência de linguagem
  - Servidor MCP — complexidade incompatível com adoção imediata
  - Prompts manuais — frágil, não persistente
- **Consequências positivas e negativas** documentadas honestamente
- **Status:** Aceito e implementado

### Arquivo criado

`knowledge/registry/adr-001-agents-md-como-veiculo-principal.md`

---

## 4. Gap — RFC-001 fora do lugar correto

### Problema

A RFC-001 (visão de plataforma futura — KOM Core, KOM MCP, KOM Memory etc.) estava salva em
`Implementações.txt`:
- Nome com caractere especial (`ç`) que pode causar problemas em sistemas sem UTF-8
- Formato `.txt` sem frontmatter nem estrutura markdown
- Fora da pasta `knowledge/registry/` onde o próprio KOM manda registrar decisões
- Sem status explícito (não ficava claro que é uma visão futura, não algo que existe hoje)

O projeto não seguia o próprio protocolo: a regra "Toda entrega gera registro" foi ignorada
para o documento mais estratégico do repositório.

### Solução

Criado `knowledge/registry/rfc-001-arquitetura-plataforma.md` com:
- **Status explícito:** "Proposta — não implementada"
- Aviso claro no topo: *"O que existe hoje é o protocolo (metodologia em markdown). Esta RFC
  descreve a evolução futura."*
- Toda a arquitetura da plataforma (KOM Core, MCP, Memory, Knowledge, Validator etc.)
- Referências cruzadas com ADR-001 e o manifesto
- Estrutura markdown completa com frontmatter de status

### Arquivo criado

`knowledge/registry/rfc-001-arquitetura-plataforma.md`

> O arquivo original `Implementações.txt` foi mantido para não quebrar referências existentes,
> mas a versão canônica é agora o arquivo no registry.

---

## 5. Gap — `knowledge/patterns/` completamente vazio

### Problema

A pasta `knowledge/patterns/` existia apenas com um `.gitkeep`. O próprio ciclo KOM (Fase 6,
Passo 3) instrui: *"Se um padrão útil foi descoberto, descreva o problema que resolve, dê um
exemplo concreto, quando usar e quando evitar."*

Durante a construção do próprio KOM 2.0, pelo menos 3 padrões emergiram claramente — e nenhum
foi registrado. O projeto não aplicou a si mesmo o que pregava.

### Solução

Criados 3 arquivos de padrões baseados nos padrões que realmente emergiram durante a construção:

---

### Pattern 001 — Fresh-Eye Audit

**Arquivo:** `knowledge/patterns/pattern-001-fresh-eye-audit.md`

**Problema que resolve:** Após construir documentação, o autor desenvolve cegueira para
inconsistências — comandos que não existem, referências quebradas, numerações erradas.

**Solução:** Antes de qualquer entrega pública, realizar auditoria com "olhar de primeira vez"
(nova sessão ou sub-agente independente). Executar todos os comandos documentados. Verificar
se cada diretório referenciado existe.

**Origem:** A fresh-eye audit do próprio KOM 2.0 revelou 6 inconsistências em uma única sessão,
incluindo o comando `graphify affected` que não existia (ver ADR-003).

---

### Pattern 002 — Separador Universal de Comandos Shell

**Arquivo:** `knowledge/patterns/pattern-002-separador-universal-shell.md`

**Problema que resolve:** `&&` funciona em bash (Linux/Mac) mas falha no PowerShell 5.1
(Windows) com `ParserError: InvalidEndOfLine`. Projetos multi-SO precisam de um separador
compatível com ambos.

**Solução:** Usar `;` no lugar de `&&` quando o segundo comando não depende do sucesso do
primeiro (ex: `echo "aviso" ; comando_real`). Quando `echo` é o primeiro comando, `;` e `&&`
são funcionalmente equivalentes.

**Origem:** Bug real corrigido no plugin `graphify.js` (ver ADR-002).

---

### Pattern 003 — ADR Sequencial com Referência Cruzada

**Arquivo:** `knowledge/patterns/pattern-003-adr-sequencial-com-referencia-cruzada.md`

**Problema que resolve:** Decisões arquiteturais se perdem ou se contradizem sem rastreamento.
Alterar uma decisão sem referenciar a anterior cria inconsistência no registry.

**Solução:** Numeração sequencial `adr-{NNN}-{titulo}.md`, nunca deletar ADRs, nunca editar
ADRs aceitos (criar novos que referenciam os anteriores), sempre marcar status e referências cruzadas.

**Origem:** Padrão que o próprio KOM 2.0 usa internamente, mas nunca havia documentado formalmente.

---

## 6. Gap — Ausência de ROADMAP separando metodologia de plataforma

### Problema

O README apresenta o KOM como "protocolo de navegação" no topo, mas a RFC-001 o chama de
"plataforma de engenharia de software para IA". Alguém que chegasse pelo README e lesse a RFC-001
não saberia distinguir o que existe hoje do que é visão futura.

Risco concreto: usuários esperando um servidor, banco de dados ou SDK ao instalar o KOM.

### Solução

Criado `ROADMAP.md` na raiz do projeto com:

- **Seção "O que existe hoje"** — tabela com todos os componentes do protocolo atual, status ✅
- **Seção "Próximas versões"** — melhorias planejadas no protocolo (CLAUDE.md, GEMINI.md,
  exemplos de uso, templates de goal.md)
- **Seção "Visão futura — Plataforma"** — componentes da RFC-001, todos com status 📋 Planejado
- **Aviso explícito:** *"Nada da v2.x existe ainda."*
- **Como contribuir** — issues, PRs, discussão sobre RFC

### Arquivo criado

`ROADMAP.md`

---

## Inventário de mudanças

| Tipo | Arquivo | Ação |
|---|---|---|
| Bug fix | `kom/07-governanca.md` | Encoding corrigido no diagrama mermaid |
| Bug fix | `kom/08-loop-engineering.md` | Caracteres CJK removidos |
| Criado | `knowledge/registry/adr-001-agents-md-como-veiculo-principal.md` | ADR faltante |
| Criado | `knowledge/registry/rfc-001-arquitetura-plataforma.md` | RFC-001 no lugar certo |
| Criado | `knowledge/patterns/pattern-001-fresh-eye-audit.md` | Padrão documentado |
| Criado | `knowledge/patterns/pattern-002-separador-universal-shell.md` | Padrão documentado |
| Criado | `knowledge/patterns/pattern-003-adr-sequencial-com-referencia-cruzada.md` | Padrão documentado |
| Criado | `ROADMAP.md` | Separação metodologia vs. plataforma |
| Criado | `CORRECAO.md` | Este arquivo |

**Total:** 2 arquivos corrigidos · 7 arquivos criados

---

## O que não foi alterado

- `Implementações.txt` — mantido para não quebrar referências. A versão canônica é agora
  `knowledge/registry/rfc-001-arquitetura-plataforma.md`.
- `graphify-out/` — o grafo está desatualizado (built no commit `29807e95`, HEAD em `871875b`).
  Atualizar requer rodar `graphify update .` localmente com Python e o pacote `graphifyy` instalado.
  Não foi atualizado porque o comando não está disponível neste ambiente.
- Todos os demais arquivos — sem alterações.

---

*Correções aplicadas por análise técnica em 30/06/2026.*
