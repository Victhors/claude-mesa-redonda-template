# LinkedIn Launch — Round Table

3 variantes com angulos diferentes. Escolha uma, ajuste o tom para a sua voz, e publique.

**Regras de ouro do LinkedIn em 2026:**
- As **2 primeiras linhas** decidem se a pessoa clica em "ver mais" — coloque o gancho ali
- Paragrafos **curtos** (1-2 linhas), com linha em branco entre eles
- **Sem emoji em excesso** (1-2 no maximo, ou nenhum)
- **Sem hashtag spam** — 3 a 5 no fim, especificas
- **CTA explicito** no final (link nos comentarios funciona melhor que no post — algoritmo penaliza link out)
- **Imagem ou carrossel** aumenta alcance em ~2x. Se tiver GIF, suba como video curto.

---

## VARIANTE A — Historia pessoal (a mais "LinkedIn")

Tom: vulneravel, narrativo, gancho emocional. Funciona muito bem em PT-BR no LinkedIn brasileiro.

```
Cansei de agentes de IA aprovando o proprio codigo.

Voce ja viu isso? O agente escreve a feature, roda os testes que ele
mesmo escreveu, declara "pronto" — e quebra em producao na quinta-feira.

Esse padrao me incomodou tanto que parei e perguntei: como times humanos
resolvem isso?

Resposta: ninguem revisa o proprio PR. Ha gates objetivos. Decisoes
ficam registradas para nao serem re-discutidas toda semana.

Entao construi um framework open source que aplica essas tres regras
a workflows multi-agente de IA: o Round Table.

Como funciona:

→ Multiplos agentes especializados (arquiteto, implementador, analista,
   pesquisador, revisor) com papeis nao-sobrepostos

→ Quem faz nunca aprova: o lider entrega, um agente diferente revisa
   como adversario

→ Cada item da spec tem um gate tipado (quantitativo, qualitativo ou
   binario) com veredito literal PASS ou FAIL

→ Se o gate falha, dispara um debate formal (maximo 3 rodadas) registrado
   em arquivo, com nivel de confianca da decisao

→ Tudo em markdown e bash. Zero dependencia. Funciona em Claude Code,
   Qwen Code e OpenCode.

E spec-driven development (SDD) com freios — porque "o agente disse que
funciona" nao e gate de qualidade.

Open source, MIT, esta no GitHub. Link nos comentarios.

Se voce ja se queimou com agente confiando demais em si mesmo, me conta
nos comentarios — quero ouvir o caso.

#AI #SoftwareEngineering #OpenSource #DeveloperTools #SpecDrivenDevelopment
```

**Primeiro comentario (voce posta):**
```
Repo: https://github.com/<voce>/round-table

Quickstart em 2 comandos:
  ./scaffold.sh ~/seu-projeto
  /init

Aceito issues, PRs e criticas duras.
```

---

## VARIANT A — English version

Same personal-story angle, adapted for LinkedIn US/EU audience. Tone is slightly tighter (English LinkedIn punishes verbosity more than PT-BR).

```
I got tired of AI agents approving their own code.

You've seen this, right? The agent writes the feature, runs the tests
it wrote itself, declares "done" — and breaks production on Thursday
afternoon.

That pattern bothered me enough that I stopped and asked: how do human
teams solve this?

Answer: nobody reviews their own PR. There are objective gates.
Decisions get recorded so they aren't re-litigated every week.

So I built an open-source framework that applies those three rules to
multi-agent AI workflows: Round Table.

How it works:

→ Multiple specialized agents (architect, implementer, analyst,
   researcher, reviewer) with non-overlapping roles

→ Whoever does the work never approves it: the leader delivers, a
   different agent reviews adversarially

→ Every spec item has a typed gate (quantitative, qualitative, or
   binary) with a literal PASS or FAIL verdict

→ Failed gate triggers a formal debate (max 3 rounds), recorded with
   confidence level

→ All markdown and bash. Zero dependencies. Works with Claude Code,
   Qwen Code, and OpenCode.

Spec-driven development with brakes — because "the agent said it works"
is not a quality gate.

Open source, MIT, on GitHub. Link in the comments.

If a self-confident agent has burned you before, drop the story in the
comments — I want to hear it.

#AI #SoftwareEngineering #OpenSource #DeveloperTools #SpecDrivenDevelopment
```

**First comment (you post):**
```
Repo: https://github.com/<you>/round-table

Two-command quickstart:
  ./scaffold.sh ~/your-project
  /init

Issues, PRs, and harsh criticism welcome.
```

**Notes for the EN version:**
- The "Thursday afternoon" detail is intentional — specificity outperforms generic "in production" on LinkedIn EN.
- "Burned you before" is colloquial enough to land in tech LinkedIn without sounding stiff. Adjust if your voice is more formal.
- If your audience is heavily US-based, swap "spec-driven development with brakes" for **"discipline layer for AI-assisted development"** — it tests slightly better in US tech LinkedIn copy.

---

## VARIANTE B — Tecnica/produto (para audiencia dev senior)

Tom: direto, com numeros e tabela. Funciona bem em audiencia tech-pesada (CTOs, staff engineers, founders tecnicos).

```
Acabei de open-sourcear o Round Table — um framework de desenvolvimento
agentico spec-driven (SDD) que impede agentes de IA de aprovarem o
proprio codigo.

O problema:
Workflows agenticos atuais tem 3 doencas — um agente faz tudo, "pronto"
nao tem definicao objetiva, e decisoes evaporam entre sessoes.

A solucao:
Round Table aplica 3 regras invioláveis ao loop multi-agente:

1. Lider != Revisor — quem faz nunca aprova
2. Cada item da spec tem gate tipado (quant/qual/binario) com PASS/FAIL
3. Falha de gate dispara debate formal (max 3 rodadas, criterio de
   resolucao explicito, decisao registrada com nivel de confianca)

vs. CrewAI / AutoGen / LangGraph:
Esses sao otimos para agentes em producao. Round Table e a camada de
disciplina para desenvolvimento assistido por IA — onde humanos dirigem
e agentes precisam ganhar confianca.

Stack:
Markdown + bash. Zero runtime. Funciona em Claude Code, Qwen Code e
OpenCode (vendor-neutral via AGENTS.md).

Quickstart (2 comandos):
  ./scaffold.sh ~/seu-projeto
  /init

MIT licensed. Link no primeiro comentario.

Curioso pra ouvir de quem ja rodou loops multi-agente em codigo de
producao — o que voces fizeram para impedir falsos positivos do agente?

#AIEngineering #DeveloperProductivity #MultiAgent #OpenSource #ClaudeCode
```

**Primeiro comentario:**
```
https://github.com/<voce>/round-table

Tabela comparativa completa (vs CrewAI/AutoGen/LangGraph) no README.
PRs e issues bem-vindos.
```

---

## VARIANTE C — Hot take / contrarian (maior reach, mais polemico)

Tom: provocativo, opinionado, gera engajamento via discordancia. Use se voce esta confortavel defendendo a posicao nos comentarios.

```
Hot take: a maioria dos frameworks de "agentes autonomos" lancados em
2025-2026 e teatro.

O agente escreve, testa e revisa o proprio codigo. Declara "pronto".
Quebra em producao. O time descobre que os "testes passando" foram
escritos pelo mesmo agente que escreveu a feature.

Isso nao e desenvolvimento assistido por IA. E vibe-coding com extra
steps.

Open-sourcei hoje o Round Table — um framework que vai na direcao
oposta: disciplina em vez de autonomia teatral.

3 regras:
→ Lider nunca e Revisor (sem auto-aprovacao)
→ Toda spec tem gate tipado com PASS/FAIL literal
→ Gate falhou = debate formal entre agentes, registrado, com nivel de
   confianca da decisao

Markdown e bash. Zero dependencia. Funciona em Claude Code, Qwen Code
e OpenCode.

Nao substitui LangGraph para pipelines de producao. Substitui o
"deixa o agente se virar" que a maioria dos times esta fingindo que
funciona.

MIT. Link no primeiro comentario.

Discordo? Otimo, comenta. Esse e o tipo de assunto que precisa de
debate publico.

#AI #SoftwareEngineering #OpenSource #AgenticAI
```

**Primeiro comentario:**
```
Repo: https://github.com/<voce>/round-table

Para a critica obvia ("e so um wrapper de prompts") — leia o README,
especialmente as condicoes de parada explicitas e o protocolo de
debate. Nao e wrapper, e protocolo.
```

---

## Recomendacao

**Se voce e PT-BR e quer maximo alcance no LinkedIn brasileiro:** Variante A.
A mais segura, gera comentarios "tambem ja passei por isso", algoritmo do LinkedIn ama narrativa pessoal.

**Se sua audiencia e majoritariamente senior/internacional:** Variante B em ingles (traduzo se quiser).
Conversao mais alta para stars no GitHub, mas alcance menor.

**Se voce quer viralizar e nao tem medo de defender posicao nos comments:** Variante C.
Maior potencial de viralizacao + maior risco de tomar criticas pesadas.

---

## Timing

- **Melhor horario PT-BR:** terca a quinta, **8h-10h** ou **18h-20h**
- **Pior horario:** sexta a tarde, fim de semana
- Se o post bombar nas primeiras 2 horas, o algoritmo amplifica por 24-48h
- **Responda TODOS os comentarios nas primeiras 4 horas** — peso enorme no algoritmo

## Material visual (recomendado, nao opcional)

LinkedIn da ~2x reach para post com imagem/video. Opcoes em ordem de esforco:

1. **Carrossel de 5 slides** (PDF, formato 1080x1350): capa com hook + os 3 mandamentos + diagrama do loop + CTA. Maior reach historico.
2. **GIF curto** (15-30s) do `/mesa-redonda` rodando, salvo como MP4 vertical
3. **Print do README** com hero centralizado — minimo esforco, ja ajuda

## Anti-recomendacoes

- **NAO** use "🚀" no titulo. Algoritmo do LinkedIn rebaixa em 2026.
- **NAO** ponha o link no corpo — ponha no primeiro comentario.
- **NAO** marque @Anthropic ou @Claude se nao tem relacao. Parece spam.
- **NAO** use "Game changer", "revolutionary", "disrupting" — gatilhos de cringe.
