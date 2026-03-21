Execute review cross-agente sobre o resultado de $ARGUMENTS.

1. Identifique o agente LIDER que executou a tarefa em $ARGUMENTS
2. Selecione agente REVISOR (diferente do lider — use a tabela de afinidade em AGENTS.md)
3. O conhecimento do revisor esta em `.claude/agents/[revisor].md` — consulte se necessario
4. Revise com olhar ADVERSARIO:
   - Resultados reprodutiveis?
   - Uma variavel por vez? Baseline registrado?
   - Testes passando? Cobertura adequada?
   - Resultado bom demais? Verificar se ha problemas ocultos
   - Consistente com decisoes registradas no DEBATE_LOG.md?
   - JOURNAL.md atualizado?
5. Se APROVADO: registre "Review aprovado por [revisor]" no JOURNAL
6. Se PROBLEMA: registre no DEBATE_LOG.md, descreva o problema e invoque `/debate`
