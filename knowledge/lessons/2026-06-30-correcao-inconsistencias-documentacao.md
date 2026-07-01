# Lição: 2026-06-30 — Correção de inconsistências na documentação

## 1. O que eu faria diferente?

Validaria todos os comandos de ferramentas de terceiros (graphify) contra a documentação real ANTES de referenciá-los em 4 arquivos diferentes. Um único comando falso (`graphify affected`) propagou-se por 3 skills/fases sem verificação.

## 2. Alguma decisão foi subótima?

Sim — a decisão de criar `graphify affected` como conceito sem verificar se o comando existia. Isso sugere que o autor escreveu a documentação baseado em "como eu quero que funcione" em vez de "como realmente funciona".

## 3. Algum padrão útil emergiu?

**Fresh-eye audit é eficaz para detectar inconsistências.** Uma revisão com olhar de "primeira vez" revelou 6 problemas que usuários reais encontraríam. Incorporar este padrão na Fase 5 (Verificação) como etapa obrigatória para projetos públicos.

## 4. O que deu errado que poderia ter sido evitado?

Tudo. Estes são problemas de documentação simples que uma revisão antes do commit teria pegado:
- Falta de verificação cruzada entre comandos documentados e reais
- Título "Fase 8" contradizendo o ciclo de 6 fases
- Diretórios referenciados mas não criados

## 5. O que devo registrar para o futuro?

- Criar um script ou checklist de verificação de integridade: comandos de terceiros, referências cruzadas, consistência de numeração
- Adicionar etapa de "mapa completo" na Fase 2: antes de lançar, verificar se toda estrutura listada nos docs existe
