module Mint
  class Parser
    syntax_error WhereExpectedExpression
    syntax_error WhereExpectedEqualSign

    def where_statement : Ast::WhereStatement | Nil
      start do |start_position|
        target = variable || tuple_destructuring
        skip unless target
        whitespace

        char '=', WhereExpectedEqualSign
        whitespace

        expression = expression! WhereExpectedExpression

        Ast::WhereStatement.new(
          expression: expression,
          from: start_position,
          target: target,
          to: position,
          input: data)
      end
    end
  end
end
