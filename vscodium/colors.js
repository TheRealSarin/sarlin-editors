const HEX_LITERAL = /0x([0-9A-Fa-f]+)(?![0-9A-Za-z_])/y;
const EXTERNAL_START = /^\s*external\s+[A-Za-z_][A-Za-z0-9_]*\s+func\s+[A-Za-z_][A-Za-z0-9_]*\s*\(/;
const EXTERNAL_END = /^\s*end\s+external\s*$/;
const BLOCK_COMMENT_FENCE = /^\s*###\s*$/;
const WORD_CHAR = /[A-Za-z0-9_]/;

function toColor(digits) {
  const byte = (index) => parseInt(digits.slice(index, index + 2), 16) / 255;
  return {
    red: byte(0),
    green: byte(2),
    blue: byte(4),
    alpha: digits.length === 8 ? byte(6) : 1,
  };
}

function findHexColorsInLine(line, lineNumber) {
  const found = [];
  let inString = false;
  for (let index = 0; index < line.length; index++) {
    const char = line[index];
    if (char === '"') {
      inString = !inString;
    } else if (!inString && char === '#') {
      break;
    } else if (!inString && char === '0' && !WORD_CHAR.test(line[index - 1] || '')) {
      HEX_LITERAL.lastIndex = index;
      const match = HEX_LITERAL.exec(line);
      if (match) {
        if (match[1].length === 6 || match[1].length === 8) {
          found.push({
            line: lineNumber,
            start: index,
            end: index + match[0].length,
            color: toColor(match[1]),
          });
        }
        index += match[0].length - 1;
      }
    }
  }
  return found;
}

function findHexColors(text) {
  const found = [];
  let inExternal = false;
  let inBlockComment = false;
  text.split(/\r?\n/).forEach((line, lineNumber) => {
    if (inExternal) {
      inExternal = !EXTERNAL_END.test(line);
    } else if (inBlockComment) {
      inBlockComment = !BLOCK_COMMENT_FENCE.test(line);
    } else if (EXTERNAL_START.test(line)) {
      inExternal = true;
    } else if (BLOCK_COMMENT_FENCE.test(line)) {
      inBlockComment = true;
    } else {
      found.push(...findHexColorsInLine(line, lineNumber));
    }
  });
  return found;
}

function formatHexColor(color, originalDigitCount) {
  const hex = (value) =>
    Math.round(value * 255).toString(16).toUpperCase().padStart(2, '0');
  const opaque = Math.round(color.alpha * 255) === 255;
  const alpha = opaque && originalDigitCount === 6 ? '' : hex(color.alpha);
  return `0x${hex(color.red)}${hex(color.green)}${hex(color.blue)}${alpha}`;
}

module.exports = { findHexColors, formatHexColor };
