module Mint
  class Parser
    def catch_all : Ast::CatchAll | Nil
      start do |start_position|
        skip unless keyword "catch"

        head_comments, expression, tail_comments = block_with_comments(
          opening_bracket: CatchExpectedOpeningBracket,
          closing_bracket: CatchExpectedClosingBracket) do
          expression! CatchExpectedExpression
        end

        Ast::CatchAll.new(
          expression: expression.as(Ast::Expression),
          head_comments: head_comments,
          tail_comments: tail_comments,
          from: start_position,
          to: position,
          input: data)
      end
    end
  end
end
