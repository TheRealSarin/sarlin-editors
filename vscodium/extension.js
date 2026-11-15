const vscode = require('vscode');
const { findHexColors, formatHexColor } = require('./colors');

const colorProvider = {
  provideDocumentColors(document) {
    return findHexColors(document.getText()).map(
      ({ line, start, end, color }) =>
        new vscode.ColorInformation(
          new vscode.Range(line, start, line, end),
          new vscode.Color(color.red, color.green, color.blue, color.alpha)
        )
    );
  },

  provideColorPresentations(color, { document, range }) {
    const originalDigitCount = document.getText(range).length - 2;
    return [new vscode.ColorPresentation(formatHexColor(color, originalDigitCount))];
  },
};

function activate(context) {
  context.subscriptions.push(
    vscode.languages.registerColorProvider({ language: 'sarlin' }, colorProvider)
  );
}

module.exports = { activate };
