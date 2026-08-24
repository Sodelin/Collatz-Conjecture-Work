# Portable Markdown math style

**Node ID:** `Collatz-Conjecture-Work:MARKDOWN-MATH-STYLE`

**Node type:** `standard`

The public notes must render as mathematics on both GitHub and Obsidian. Raw
LaTeX delimiters that either viewer treats as ordinary text are not an
acceptable reading interface.

## Shared delimiter contract

- Inline math: `$x^2+y^2=z^2$`
- Display math: put `$$` on its own line before and after the TeX body.
- Keep TeX commands inside a math delimiter.
- Keep literal code examples inside backticks or fenced code blocks.
- Put a literal dollar sign in an inline code span. When ordinary prose on the
  same line as math requires it, use `<span>$</span>`.

GitHub also supports a fenced `math` block, but standalone `$$` is the shared
format used here because it renders in both GitHub Markdown and Obsidian.

Do not use `\(`…`\)` or standalone `\[`…`\]` in human-facing Markdown. Those
legacy delimiters are easy to expose as raw text in one of the target viewers.

## Mechanical checker

From the repository root:

```powershell
python -B verification\check_markdown_math.py --self-test
```

The checker ignores fenced code, inline code, and indented code. Its `--fix`
mode changes only matched legacy delimiter pairs and standalone display
delimiter lines; it does not edit the TeX bodies. Review the resulting diff,
then rerun the checker without `--fix`.

This is presentation QA. It does not validate any equation or mathematical
claim.

## Platform references

- [GitHub mathematical expressions](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/writing-mathematical-expressions)
- [Obsidian advanced syntax — Math](https://obsidian.md/help/advanced-syntax#Math)

## Connections

- **Depends on:** [portable proof-note graph standard](NOTE_GRAPH_STANDARD.md)
- **Verified by:** [verification manifest](../verification/README.md)
