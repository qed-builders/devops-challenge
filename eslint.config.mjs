import globals from "globals";
import pluginJs from "@eslint/js";
import pluginReactConfig from "eslint-plugin-react/configs/recommended.js";
import { fixupConfigRules } from "@eslint/compat";

export default [
  {
    languageOptions: {
      globals: {
        ...globals.browser,
        ...globals.node,  // Add Node.js globals
        commonjs: true    // Add CommonJS globals
      },
      ecmaVersion: 2021,
      sourceType: 'module',
    }
  },
  pluginJs.configs.recommended,
  {
    files: ["**/*.jsx"],
    languageOptions: {
      parserOptions: {
        ecmaFeatures: {
          jsx: true
        }
      }
    }
  },
  ...fixupConfigRules(pluginReactConfig),
  {
    rules: {
      "no-unused-vars": ["error", { "argsIgnorePattern": "^_" }]
    }
  }
];
