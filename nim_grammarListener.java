// Generated from nim_grammar.g4 by ANTLR 4.7.2
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link nim_grammarParser}.
 */
public interface nim_grammarListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link nim_grammarParser#start}.
	 * @param ctx the parse tree
	 */
	void enterStart(nim_grammarParser.StartContext ctx);
	/**
	 * Exit a parse tree produced by {@link nim_grammarParser#start}.
	 * @param ctx the parse tree
	 */
	void exitStart(nim_grammarParser.StartContext ctx);
}