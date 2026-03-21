Faca code review do PR $ARGUMENTS:

1. Use `gh pr view $ARGUMENTS` para ver o PR
2. Use `gh pr diff $ARGUMENTS` para ver o diff completo
3. Analise cada arquivo modificado:
   - Qualidade do codigo: legibilidade, manutencao, boas praticas
   - Testes: cobertura adequada? Testes novos para codigo novo?
   - Seguranca: OWASP top 10, secrets expostos, injection?
   - Performance: N+1 queries, loops desnecessarios, memory leaks?
   - Aderencia aos padroes do projeto (CLAUDE.md)
4. Classifique cada issue:
   - CRITICO: deve corrigir antes de merge
   - ALERTA: deveria corrigir
   - SUGESTAO: melhoria opcional
5. Reporte em formato estruturado
