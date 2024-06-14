import globals from 'globals';
import pluginJs from '@eslint/js';
import pluginReactConfig from 'eslint-plugin-react/configs/recommended.js';
import { fixupConfigRules } from '@eslint/compat';
import pluginJest from 'eslint-plugin-jest';

export default [
  {
    languageOptions: {
      globals: {
        ...globals.browser,
        ...globals.node, 
        commonjs: true    
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
    files: ["**/__tests__/**/*.js?(x)", "**/?(*.)+(spec|test).[tj]s?(x)"],
    plugins: {
      jest: pluginJest,
    },
    languageOptions: {
      globals: {
        ...globals.jest,
      }
    },
    rules: {
      'no-unused-vars': ['error', { argsIgnorePattern: '^_' }],
    }
  }
];
