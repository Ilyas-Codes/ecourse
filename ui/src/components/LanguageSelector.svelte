<!-- LanguageSelector.svelte -->
<script>
    import translations from '../lib/translation'; // Update the path to your translations.js file
    import { locale, locales } from '../lib/i18n';
  
    function changeLanguage(event) {
      locale.set(event.target.value);
    }
  
    // Map language codes to their display names
    let languageNames = Object.fromEntries(
      locales.map(lang => [lang, translations[lang]?.name || lang])
    );
  </script>
  
  <select
    on:change={changeLanguage}
    class="bg-gray-700 border border-gray-600 text-white text-sm rounded-md focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 placeholder-gray-400"
  >
    {#each locales as lang}
      <option value={lang} class="bg-gray-700 text-white">
        {languageNames[lang]}
      </option>
    {/each}
  </select>
  