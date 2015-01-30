angular.module "rsfIndex2015"
  .config ($translateProvider) ->
    $translateProvider
      .useStaticFilesLoader
        prefix: 'assets/locale/'
        suffix: '.json'
      .registerAvailableLanguageKeys ['en', 'fr', 'es'],
        'en_US': 'en'
        'en_UK': 'en'
        'fr_FR': 'fr'
        'fr_CA': 'fr'
        'fr_BE': 'fr'
        'es_ES': 'es'
      .determinePreferredLanguage ->
        lang = navigator.language || navigator.userLanguage
        avalaibleKeys = [
          'en_US', 'en_UK', 'en',
          'fr_FR', 'fr_CA', 'fr_BE', 'fr',
          'es_ES', 'es'
        ]
        return if avalaibleKeys.indexOf(lang) is -1 then 'en' else lang
      .fallbackLanguage ['en', 'fr']
      .useMessageFormatInterpolation()
      .useCookieStorage()
