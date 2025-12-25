// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get accountUpgradedSuccessfully => 'CUENTA ACTUALIZADA CON ÉXITO';

  @override
  String get lotPerWeek => 'Lote/semana';

  @override
  String get tableValueFull => 'completo';

  @override
  String get tableValueFulltime => 'tiempo completo';

  @override
  String get packageTitle => 'PAQUETE';

  @override
  String get duration1Month => '1 mes';

  @override
  String get duration12Months => '12 meses';

  @override
  String get featureReceiveAllSignals => 'Recibir todas las señales del día';

  @override
  String get featureAnalyzeReason => 'Analizar la razón para ingresar la orden';

  @override
  String get featureHighPrecisionAI => 'Señal de IA de alta precisión';

  @override
  String get iapStoreNotAvailable =>
      'La tienda no está disponible en este dispositivo.';

  @override
  String iapErrorLoadingProducts(Object message) {
    return 'Error al cargar productos: $message';
  }

  @override
  String get iapNoProductsFound =>
      'No se encontraron productos. Por favor, verifique la configuración de su tienda.';

  @override
  String iapTransactionError(Object message) {
    return 'Error de transacción: $message';
  }

  @override
  String iapVerificationError(Object message) {
    return 'Error de verificación: $message';
  }

  @override
  String iapUnknownError(Object error) {
    return 'Ocurrió un error desconocido: $error';
  }

  @override
  String get iapProcessingTransaction => 'Procesando transacción...';

  @override
  String get orderInfo1Month => 'Pago por paquete Elite de 1 mes';

  @override
  String get orderInfo12Months => 'Pago por paquete Elite de 12 meses';

  @override
  String get iapNotSupportedOnWeb =>
      'Las compras dentro de la aplicación no son compatibles con la versión web.';

  @override
  String get vnpayPaymentTitle => 'PAGO VNPAY';

  @override
  String get creatingOrderWait => 'Creando pedido, por favor espere...';

  @override
  String errorWithMessage(Object message) {
    return 'Error: $message';
  }

  @override
  String get cannotConnectToServer =>
      'No se puede conectar al servidor. Por favor, inténtelo de nuevo.';

  @override
  String get transactionCancelledOrFailed =>
      'La transacción ha sido cancelada o falló.';

  @override
  String get cannotCreatePaymentLink =>
      'No se pudo crear el enlace de pago.\nInténtelo de nuevo.';

  @override
  String get retry => 'Reintentar';

  @override
  String serverErrorRetry(Object message) {
    return 'Error del servidor: $message. Por favor, inténtelo de nuevo.';
  }

  @override
  String get redirectingToPayment => 'Redirigiendo a la página de pago...';

  @override
  String get invalidPaymentUrl =>
      'URL de pago no válida recibida del servidor.';

  @override
  String get processingYourAccount => 'Procesando su cuenta...';

  @override
  String get verificationFailed => '¡Verificación fallida!';

  @override
  String get reuploadImage => 'Volver a subir imagen';

  @override
  String get accountNotLinked => 'Cuenta no vinculada a Minvest';

  @override
  String get accountNotLinkedDesc =>
      'Para obtener señales exclusivas, su cuenta Exness debe estar registrada a través del enlace de socio de Minvest. Por favor, cree una nueva cuenta utilizando el enlace a continuación.';

  @override
  String get registerExnessViaMinvest => 'Registrar Exness vía Minvest';

  @override
  String get iHaveRegisteredReupload => 'Me he registrado, volver a subir';

  @override
  String couldNotLaunch(Object url) {
    return 'No se pudo iniciar $url';
  }

  @override
  String get status => 'Estado';

  @override
  String get sentOn => 'Enviado el';

  @override
  String get entryPrice => 'Precio de entrada';

  @override
  String get stopLossFull => 'Stop loss';

  @override
  String get takeProfitFull1 => 'Take profit 1';

  @override
  String get takeProfitFull2 => 'Take profit 2';

  @override
  String get takeProfitFull3 => 'Take profit 3';

  @override
  String get noReasonProvided =>
      'No se proporcionó ninguna razón para esta señal.';

  @override
  String get upgradeToViewReason =>
      'Actualice su cuenta a Elite para ver el análisis.';

  @override
  String get upgradeToViewFullAnalysis =>
      'Actualice para Ver Análisis Completo';

  @override
  String get welcomeTo => 'Bienvenido a';

  @override
  String get appSlogan => 'Mejore su trading con señales inteligentes.';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get continueByGoogle => 'Continuar con Google';

  @override
  String get continueByFacebook => 'Continuar con Facebook';

  @override
  String get continueByApple => 'Continuar con Apple';

  @override
  String get loginSuccess => '¡Inicio de sesión exitoso!';

  @override
  String get live => 'EN VIVO';

  @override
  String get end => 'FIN';

  @override
  String get symbol => 'SÍMBOLO';

  @override
  String get aiSignal => 'Señales de IA';

  @override
  String get ruleSignal => 'SEÑAL DE REGLA';

  @override
  String get all => 'TODO';

  @override
  String get upgradeToSeeMore => 'Actualice para ver más';

  @override
  String get seeDetails => 'ver detalles';

  @override
  String get notMatched => 'NO COINCIDE';

  @override
  String get matched => 'COINCIDE';

  @override
  String get entry => 'Entrada';

  @override
  String get stopLoss => 'SL';

  @override
  String get takeProfit1 => 'TP1';

  @override
  String get takeProfit2 => 'TP2';

  @override
  String get takeProfit3 => 'TP3';

  @override
  String get upgrade => 'Actualizar';

  @override
  String get upgradeAccount => 'ACTUALIZAR CUENTA';

  @override
  String get compareTiers => 'COMPARAR NIVELES';

  @override
  String get feature => 'Característica';

  @override
  String get tierDemo => 'Demo';

  @override
  String get tierVIP => 'VIP';

  @override
  String get tierElite => 'Elite';

  @override
  String get balance => 'Saldo';

  @override
  String get signalTime => 'Hora de la señal';

  @override
  String get signalQty => 'Cant. de señales';

  @override
  String get analysis => 'Análisis';

  @override
  String get openExnessAccount => '¡Abrir cuenta Exness!';

  @override
  String get accountVerificationWithExness =>
      'Verificación de cuenta con Exness';

  @override
  String get payInAppToUpgrade => 'Pagar en la app para actualizar';

  @override
  String get bankTransferToUpgrade => 'Transferencia bancaria para actualizar';

  @override
  String get accountVerification => 'VERIFICACIÓN DE CUENTA';

  @override
  String get accountVerificationPrompt =>
      'Por favor, suba una captura de pantalla de su cuenta Exness para ser autorizado (su cuenta debe abrirse bajo el enlace de Exness de Minvest)';

  @override
  String get selectPhotoFromLibrary => 'Seleccionar foto de la biblioteca';

  @override
  String get send => 'Enviar';

  @override
  String get accountInfo => 'Información de la cuenta';

  @override
  String get accountVerifiedSuccessfully => 'CUENTA VERIFICADA CON ÉXITO';

  @override
  String get yourAccountIs => 'Su cuenta es';

  @override
  String get returnToHomePage => 'Volver a la página de inicio';

  @override
  String get upgradeFailed =>
      '¡Actualización fallida! Por favor, vuelva a subir la imagen';

  @override
  String get package => 'PAQUETE';

  @override
  String get startNow => 'Obtener Señales Ahora';

  @override
  String get bankTransfer => 'TRANSFERENCIA BANCARIA';

  @override
  String get transferInformation => 'INFORMACIÓN DE TRANSFERENCIA';

  @override
  String get scanForFastTransfer => 'Escanear para transferencia rápida';

  @override
  String get contactUs247 => 'Contáctenos 24/7';

  @override
  String get newAnnouncement => 'NUEVO ANUNCIO';

  @override
  String get profile => 'Perfil';

  @override
  String get upgradeNow => 'Actualizar Ahora';

  @override
  String get followMinvest => 'Seguir a MInvest';

  @override
  String get tabSignal => 'Señal';

  @override
  String get tabChart => 'Gráfico';

  @override
  String get tabProfile => 'Perfil';

  @override
  String get reason => 'RAZÓN';

  @override
  String get error => 'Error';

  @override
  String get noSignalsAvailable => 'No hay señales disponibles.';

  @override
  String get outOfGoldenHours => 'Fuera de Horas Doradas';

  @override
  String get outOfGoldenHoursVipDesc =>
      'Las señales VIP están disponibles de 8:00 AM a 5:00 PM (GMT+7).\n¡Actualice a Elite para obtener señales 24/24!';

  @override
  String get outOfGoldenHoursDemoDesc =>
      'Las señales Demo están disponibles de 8:00 AM a 5:00 PM (GMT+7).\n¡Actualice su cuenta para más beneficios!';

  @override
  String get yourName => 'Su Nombre';

  @override
  String get yourEmail => 'su.email@ejemplo.com';

  @override
  String get adminPanel => 'Panel de Administración';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get confirmLogout => 'Confirmar Cierre de Sesión';

  @override
  String get confirmLogoutMessage => '¿Está seguro de que desea cerrar sesión?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get upgradeCardTitle => 'ACTUALICE SU CUENTA';

  @override
  String get upgradeCardSubtitle => 'Para acceder a más recursos';

  @override
  String get upgradeCardSubtitleWeb =>
      'Para desbloquear señales premium y soporte a tiempo completo';

  @override
  String get subscriptionDetails => 'Detalles de Suscripción';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get continueAsGuest => 'Continuar como Invitado';

  @override
  String get deleteAccount => 'Eliminar Cuenta';

  @override
  String get deleteAccountWarning =>
      '¿Está seguro de que desea eliminar su cuenta? Todos sus datos serán borrados permanentemente y no podrán recuperarse.';

  @override
  String get delete => 'Eliminar';

  @override
  String get privacyPolicy => 'Política de Privacidad';

  @override
  String get termsOfService => 'Términos de Servicio';

  @override
  String get signalStatusMatched => 'COINCIDE';

  @override
  String get signalStatusNotMatched => 'NO COINCIDE';

  @override
  String get signalStatusCancelled => 'CANCELADO';

  @override
  String get signalStatusSlHit => 'SL ALCANZADO';

  @override
  String get signalStatusTp1Hit => 'TP1 ALCANZADO';

  @override
  String get signalStatusTp2Hit => 'TP2 ALCANZADO';

  @override
  String get signalStatusTp3Hit => 'TP3 ALCANZADO';

  @override
  String get signalStatusRunning => 'EN EJECUCIÓN';

  @override
  String get signalStatusClosed => 'CERRADO';

  @override
  String get contactUs => 'Contáctenos';

  @override
  String get tabChat => 'Chat';

  @override
  String get exnessUpgradeNoteForIos =>
      'Para los clientes que han registrado una cuenta Exness a través de Minvest, por favor haga clic en contáctenos para actualizar su cuenta.';

  @override
  String get chatWelcomeTitle => '👋 ¡Bienvenido a Signal GPT!';

  @override
  String get chatWelcomeBody1 =>
      'Por favor deje un mensaje, nuestro equipo responderá lo antes posible.';

  @override
  String get chatWelcomeBody2 =>
      'O contáctenos directamente vía Zalo/WhatsApp: ';

  @override
  String get chatWelcomeBody3 => ' para soporte más rápido!';

  @override
  String get chatLoginPrompt =>
      'Por favor inicie sesión para usar esta función';

  @override
  String get chatStartConversation => 'Inicie su conversación';

  @override
  String get chatNoMessages => 'Aún no hay mensajes.';

  @override
  String get chatTypeMessage => 'Escriba un mensaje...';

  @override
  String get chatSupportIsTyping => 'Soporte está escribiendo...';

  @override
  String chatUserIsTyping(Object userName) {
    return '$userName está escribiendo...';
  }

  @override
  String get chatSeen => 'Visto';

  @override
  String get chatDefaultUserName => 'Usuario';

  @override
  String get chatDefaultSupportName => 'Soporte';

  @override
  String get signalEntry => 'Entrada';

  @override
  String get price1Month => '\$78';

  @override
  String get price12Months => '\$460';

  @override
  String get foreignTraderSupport =>
      'Para traders extranjeros, por favor contáctenos vía WhatsApp (+84969.15.6969) para soporte';

  @override
  String get signalSl => 'SL';

  @override
  String get upgradeToSeeDetails =>
      'Actualice para ver detalles de la señal...';

  @override
  String get buy => 'COMPRAR';

  @override
  String get sell => 'VENDER';

  @override
  String get logoutDialogTitle => 'Sesión Expirada';

  @override
  String get logoutDialogDefaultReason =>
      'Su cuenta ha iniciado sesión en otro dispositivo.';

  @override
  String get ok => 'OK';

  @override
  String get contactToUpgrade => 'Contactar para actualizar';

  @override
  String get noNotificationsYet => 'Aún no hay notificaciones.';

  @override
  String daysAgo(int count) {
    return 'hace $count días';
  }

  @override
  String hoursAgo(int count) {
    return 'hace $count horas';
  }

  @override
  String minutesAgo(int count) {
    return 'hace $count minutos';
  }

  @override
  String get justNow => 'Justo ahora';

  @override
  String get getSignalsNow => 'Obtener Señales Ahora';

  @override
  String get freeTrial => 'Prueba Gratis';

  @override
  String get heroTitle => 'Guiando Traders y Creciendo Portafolios';

  @override
  String get heroSubtitle =>
      'El Motor de IA Definitivo – Diseñado por Traders Expertos';

  @override
  String get globalAiInnovationTitle =>
      'Innovación Global en IA para la Próxima Generación de Inteligencia de Trading';

  @override
  String get globalAiInnovationDesc =>
      'Transformando el trading tradicional con señales de IA impulsadas por la nube — adaptables a las noticias y tendencias del mercado en tiempo real\npara un rendimiento más rápido, preciso y libre de emociones.';

  @override
  String get liveTradingSignalsTitle =>
      'EN VIVO – Señales de Trading con IA 24/7';

  @override
  String get liveTradingSignalsDesc =>
      'Analíticas en la nube en tiempo real que ofrecen estrategias de seguimiento de tendencias de alta probabilidad con precisión adaptativa y ejecución libre de emociones.';

  @override
  String get trendFollowing => 'Seguimiento de Tendencias';

  @override
  String get realtime => 'Tiempo real';

  @override
  String get orderExplanationEngineTitle => 'Motor de Explicación de Órdenes';

  @override
  String get orderExplanationEngineDesc =>
      'Explica las configuraciones comerciales en términos simples — mostrando cómo se forman las confluencias, por qué se realizan las entradas, y ayudando a los traders a aprender de cada decisión.';

  @override
  String get transparent => 'Transparente';

  @override
  String get educational => 'Educativo';

  @override
  String get logical => 'Lógico';

  @override
  String get transparentRealPerformanceTitle =>
      'Transparente - Rendimiento Real';

  @override
  String get transparentRealPerformanceDesc =>
      'Vea datos reales sobre la precisión de la señal, tasa de éxito y rentabilidad — verificados y rastreables en cada operación';

  @override
  String get results => 'Resultados';

  @override
  String get performanceTracking => 'Seguimiento de Rendimiento';

  @override
  String get accurate => 'Preciso';

  @override
  String get predictiveAccuracy => 'Precisión Predictiva';

  @override
  String get improvementInProfitability => 'Mejora en la Rentabilidad';

  @override
  String get improvedRiskManagement => 'Gestión de Riesgos Mejorada';

  @override
  String get signalsPerformanceTitle => 'Rendimiento de Señales';

  @override
  String get riskToRewardRatio => 'Relación Riesgo-Recompensa';

  @override
  String get howRiskComparesToReward =>
      'Cómo se compara el riesgo con la recompensa';

  @override
  String get profitLossOverview => 'Resumen de Ganancias/Pérdidas';

  @override
  String get netGainVsLoss => 'Ganancia neta vs pérdida';

  @override
  String get winRate => 'Tasa de Ganancia';

  @override
  String get percentageOfWinningTrades => 'Porcentaje de operaciones ganadoras';

  @override
  String get accuracyRate => 'Tasa de Precisión';

  @override
  String get howPreciseOurSignalsAre => 'Qué tan precisas son nuestras señales';

  @override
  String get realtimeMarketAnalysis => 'Análisis de Mercado en Tiempo Real';

  @override
  String get realtimeMarketAnalysisDesc =>
      'Nuestra IA monitorea el mercado continuamente, identificando zonas de convergencia técnica y puntos de ruptura confiables para que pueda ingresar a las operaciones en el momento adecuado.';

  @override
  String get saveTimeOnAnalysis => 'Ahorre Tiempo en Análisis';

  @override
  String get saveTimeOnAnalysisDesc =>
      'No más horas dedicadas a leer gráficos. Reciba estrategias de inversión personalizadas en solo unos minutos al día.';

  @override
  String get minimizeEmotionalTrading => 'Minimice el Trading Emocional';

  @override
  String get minimizeEmotionalTradingDesc =>
      'Con alertas inteligentes, detección de riesgos y señales basadas en datos no en emociones, usted se mantiene disciplinado y en control de cada decisión.';

  @override
  String get seizeEveryOpportunity => 'Aproveche Cada Oportunidad';

  @override
  String get seizeEveryOpportunityDesc =>
      'Las actualizaciones de estrategia oportunas entregadas directamente a su bandeja de entrada aseguran que aproveche las tendencias del mercado en el momento perfecto.';

  @override
  String get minvestAiCoreValueTitle => 'Signal GPT - Valor Central';

  @override
  String get minvestAiCoreValueDesc =>
      'La IA analiza datos de mercado en tiempo real continuamente, filtrando conocimientos para identificar oportunidades de inversión rápidas y precisas';

  @override
  String get frequentlyAskedQuestions => 'Preguntas Frecuentes (FAQ)';

  @override
  String get faqSubtitle =>
      'Todas sus preguntas — desde cómo unirse, hasta los beneficios, hasta cómo funciona nuestra IA — se responden justo debajo. Si aún tiene dudas, no dude en enviarnos un mensaje por Whatsapp';

  @override
  String get maximizeResultsTitle =>
      'Maximice sus resultados con Signal GPT\nanálisis de mercado avanzado y señales filtradas con precisión';

  @override
  String get elevateTradingWithAiStrategies =>
      'Eleve su trading con estrategias mejoradas por IA creadas para consistencia y claridad';

  @override
  String get winMoreWithAiSignalsTitle =>
      'Gane Más con Señales Impulsadas por IA\nen Cada Mercado';

  @override
  String get winMoreWithAiSignalsDesc =>
      'Nuestra IA multi-mercado escanea Forex, Cripto y Metales en tiempo real,\nentregando señales de trading validadas por expertos —\ncon niveles claros de entrada, stop-loss y take-profit';

  @override
  String get buyLimit => 'Límite de compra';

  @override
  String get sellLimit => 'Límite de venta';

  @override
  String get smarterToolsTitle =>
      'Herramientas Más Inteligentes - Mejores Inversiones';

  @override
  String get smarterToolsDesc =>
      'Descubra las características que le ayudan a minimizar riesgos, aprovechar oportunidades y hacer crecer su riqueza';

  @override
  String get performanceOverviewTitle => 'Resumen de Rendimiento';

  @override
  String get performanceOverviewDesc =>
      'Nuestra IA multi-mercado escanea Forex, Cripto y Metales en tiempo real, entregando señales de trading validadas por expertos - con niveles claros de entrada, stop-loss y take-profit';

  @override
  String get totalProfit => 'Beneficio Total';

  @override
  String get completionSignal => 'Señal de finalización';

  @override
  String get onDemandFinancialExpertTitle =>
      'Su Experto Financiero Bajo Demanda';

  @override
  String get onDemandFinancialExpertDesc =>
      'Plataforma de IA sugiere señales de trading - autoaprendizaje, analiza el mercado 24/7, no afectado por emociones. Minvest ha apoyado a más de 10,000 analistas financieros en su viaje para encontrar señales precisas, estables y fáciles de aplicar';

  @override
  String get aiPoweredSignalPlatform =>
      'Plataforma de Señales de Trading Impulsada por IA';

  @override
  String get selfLearningSystems =>
      'Sistemas de Autoaprendizaje, Conocimientos Más Nítidos, Operaciones Más Fuertes';

  @override
  String get emotionlessExecution =>
      'Ejecución Sin Emociones Para un Trading Más Inteligente y Disciplinado';

  @override
  String get analysingMarket247 => 'Analizando el mercado 24/7';

  @override
  String get maximizeResultsFeaturesTitle =>
      'Maximice sus resultados con Signal GPT\nanálisis de mercado avanzado y señales filtradas con precisión';

  @override
  String get minvestAiRegistrationDesc =>
      'El registro en Signal GPT está abierto ahora — las plazas pueden cerrarse pronto ya que revisamos y aprobamos nuevos miembros';

  @override
  String get currencyPairs => 'Materia Prima';

  @override
  String get allCurrencyPairs => 'Todos los Pares de Divisas';

  @override
  String get allCommodities => 'Todas las Materias Primas';

  @override
  String get allCryptoPairs => 'Todos los Pares de Cripto';

  @override
  String get dateRange => 'Rango de Fechas';

  @override
  String get selectDateRange => 'Seleccionar Rango de Fechas';

  @override
  String get allAssets => 'Todos los Activos';

  @override
  String get asset => 'Activo';

  @override
  String get tokenExpired => 'Token expirado';

  @override
  String get tokenLimitReachedDesc =>
      'Ha agotado sus 10 tokens gratuitos hoy. Actualice su paquete para ver más señales.';

  @override
  String get later => 'Más tarde';

  @override
  String get created => 'Creado';

  @override
  String get detail => 'Detalle';

  @override
  String get performanceOverview => 'Resumen de Rendimiento';

  @override
  String get totalProfitPips => 'Beneficio Total (Pips)';

  @override
  String get winRatePercent => 'Tasa de Victoria (%)';

  @override
  String get comingSoon => 'Próximamente';

  @override
  String get errorLoadingHistory => 'Error al cargar historial';

  @override
  String get noHistoryAvailable => 'No hay historial de señales disponible';

  @override
  String get previous => 'Anterior';

  @override
  String get page => 'Página';

  @override
  String get next => 'Siguiente';

  @override
  String get date => 'Fecha';

  @override
  String get timeGmt7 => 'Hora (GMT)';

  @override
  String get orders => 'Órdenes';

  @override
  String get pips => 'Pips';

  @override
  String get smallScreenRotationHint =>
      'Pantalla pequeña: rote horizontalmente o desplace horizontalmente para ver la tabla completa.';

  @override
  String get history => 'Historial';

  @override
  String get signalsWillAppearHere =>
      'Las señales aparecerán aquí cuando estén disponibles';

  @override
  String get pricing => 'Precios';

  @override
  String get choosePlanSubtitle => 'Elija un plan que funcione para usted';

  @override
  String get financialNewsHub => 'Centro de Noticias Financieras';

  @override
  String get financialNewsHubDesc =>
      'Actualizaciones críticas. Reacciones del mercado. Sin ruido – solo lo que los inversores necesitan saber.';

  @override
  String get newsTabAllArticles => 'Todos los Artículos';

  @override
  String get newsTabInvestor => 'Inversor';

  @override
  String get newsTabKnowledge => 'Conocimiento';

  @override
  String get newsTabTechnicalAnalysis => 'Análisis Técnico';

  @override
  String noArticlesForCategory(Object category) {
    return 'No hay artículos para la categoría $category';
  }

  @override
  String get mostPopular => 'Más popular';

  @override
  String get noPosts => 'Sin publicaciones';

  @override
  String get relatedArticles => 'Artículos relacionados';

  @override
  String get contactInfoSentSuccess =>
      'Información de contacto enviada con éxito.';

  @override
  String contactInfoSentFailed(Object error) {
    return 'Error al enviar información: $error';
  }

  @override
  String get contactPageSubtitle =>
      '¿Tiene preguntas o necesita soluciones de IA? ¡Háganoslo saber completando el formulario y nos pondremos en contacto!';

  @override
  String get phone => 'Teléfono';

  @override
  String get firstName => 'Nombre';

  @override
  String get enterFirstName => 'Ingrese Nombre';

  @override
  String get lastName => 'Apellido';

  @override
  String get enterLastName => 'Ingrese Apellido';

  @override
  String get whatAreYourConcerns => '¿Cuáles son sus preocupaciones?';

  @override
  String get writeConcernsHere => 'Escriba sus preocupaciones aquí...';

  @override
  String pleaseEnter(Object field) {
    return 'Por favor ingrese $field';
  }

  @override
  String get faqQuestion1 =>
      '¿Las señales aseguran una tasa de éxito del 100%?';

  @override
  String get faqAnswer1 =>
      'Si bien ninguna señal puede garantizarse al 100%, Signal GPT se esfuerza por mantener una tasa de éxito estable del 60–80%, respaldada por análisis detallados y gestión de riesgos para que pueda tomar la decisión final con mayor confianza.';

  @override
  String get faqQuestion2 =>
      'Si no quiero depositar de inmediato, ¿puedo seguir recibiendo sugerencias de señales?';

  @override
  String get faqAnswer2 =>
      'Al abrir una cuenta, el sistema le regalará 10 tokens gratuitos, equivalentes a 10 vistas detalladas de señales. Después de eso, recibirá 1 token adicional cada día para usar. Si actualiza a una cuenta VIP, desbloqueará muchas funciones avanzadas y rastreará un número ilimitado de órdenes.';

  @override
  String get faqQuestion3 =>
      'Si me he registrado pero no he recibido ninguna señal, ¿qué pasos debo seguir?';

  @override
  String get faqAnswer3 =>
      'El procesamiento suele ser automático. Si aún no ve ninguna sugerencia de señal, contáctenos por Whatsapp para obtener asistencia instantánea.';

  @override
  String get faqQuestion4 =>
      '¿Cuántas señales recibiré por día al actualizar a una cuenta VIP?';

  @override
  String get faqAnswer4 =>
      'Al actualizar a una cuenta VIP, recibirá señales de trading ilimitadas todos los días. El número de señales no es fijo, sino que depende completamente del análisis de mercado. Siempre que aparezca un punto de entrada de alta calidad y alta probabilidad, el equipo de análisis le enviará la señal de inmediato.';

  @override
  String get priceLevels => 'Niveles de Precio';

  @override
  String get capitalManagement => 'Gestión de Capital';

  @override
  String freeSignalsLeft(Object count) {
    return '$count señales gratuitas restantes';
  }

  @override
  String get unlimitedSignals => 'Señales ilimitadas';

  @override
  String get goBack => 'Volver';

  @override
  String get goldPlan => 'Plan Oro';

  @override
  String get perMonth => '/ mes';

  @override
  String get continuouslyUpdating =>
      'Actualizando datos de mercado continuamente 24/7';

  @override
  String get providingBestSignals =>
      'Proporcionando las mejores señales en tiempo real';

  @override
  String get includesEntrySlTp => 'Incluye Entrada, SL, TP';

  @override
  String get detailedAnalysis =>
      'Análisis detallado y evaluación de cada señal';

  @override
  String get realTimeNotifications =>
      'Notificaciones en tiempo real vía correo electrónico';

  @override
  String get signalPerformanceStats =>
      'Estadísticas de rendimiento de la señal';

  @override
  String get companyName => 'EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED';

  @override
  String get enterpriseCodeDetails =>
      'Número de Registro Comercial: 0110057263';

  @override
  String get addressDetails =>
      'Dirección: No. 8 Do Hanh Street, Hai Ba Trung Ward, Ciudad de Hanoi, Vietnam';

  @override
  String get pagesTitle => 'Páginas';

  @override
  String get legalRegulatoryTitle => 'Legal y Regulatorio';

  @override
  String get termsOfRegistration => 'Términos de Registro';

  @override
  String get operatingPrinciples => 'Principios Operativos';

  @override
  String get termsConditions => 'Términos y Condiciones';

  @override
  String get contactTitle => 'Contacto';

  @override
  String get navFeatures => 'Características';

  @override
  String get navNews => 'Noticias';

  @override
  String get tp1Hit => 'TP1 Alcanzado';

  @override
  String get tp2Hit => 'TP2 Alcanzado';

  @override
  String get tp3Hit => 'TP3 Alcanzado';

  @override
  String get slHit => 'SL Alcanzado';

  @override
  String get cancelled => 'Cancelado';

  @override
  String get exitedByAdmin => 'Salido por Admin';

  @override
  String get signalClosed => 'Cerrado';

  @override
  String get errorLoadingPackages => 'Error al Cargar Paquetes';

  @override
  String get monthly => 'Mensualmente';

  @override
  String get annually => 'Anualmente';

  @override
  String get whatsIncluded => 'Qué está incluido:';

  @override
  String get chooseThisPlan => 'Elegir este plan';

  @override
  String get bestPricesForPremiumAccess =>
      'Mejores Precios para Acceso Premium';

  @override
  String get choosePlanFitsNeeds =>
      'Elija un plan que se adapte a las necesidades de su negocio y comience a automatizar con IA';

  @override
  String get save50Percent => 'AHORRE 50%';

  @override
  String get tryDemo => 'Probar demo';

  @override
  String get pleaseEnterEmailPassword =>
      'Por favor ingrese correo electrónico y contraseña';

  @override
  String loginFailed(String error) {
    return 'Inicio de sesión fallido: $error';
  }

  @override
  String get welcomeBack => 'Bienvenido de Nuevo';

  @override
  String get signInToContinue => 'Inicie sesión en su cuenta para continuar';

  @override
  String get or => 'o';

  @override
  String get email => 'Correo electrónico';

  @override
  String get emailHint => 'ejemplo123@gmail.com';

  @override
  String get password => 'Contraseña';

  @override
  String get enterPassword => 'Ingrese Contraseña';

  @override
  String get forgotPassword => '¿Olvidó su contraseña?';

  @override
  String get createNewAccount => '¡Cree una nueva cuenta aquí!';

  @override
  String get signUp => 'Registrarse';

  @override
  String get signUpAccount => 'Registrar Cuenta';

  @override
  String get enterPersonalData =>
      'Ingrese sus datos personales para crear su cuenta';

  @override
  String get nameLabel => 'Nombre *';

  @override
  String get enterNameHint => 'Ingrese Nombre';

  @override
  String get emailLabel => 'Correo electrónico *';

  @override
  String get passwordLabel => 'Contraseña *';

  @override
  String get phoneLabel => 'Teléfono';

  @override
  String get continueButton => 'Continuar';

  @override
  String get fillAllFields => 'Por favor complete todos los campos requeridos.';

  @override
  String get accountCreatedSuccess => 'Cuenta creada con éxito.';

  @override
  String signUpFailed(String error) {
    return 'Registro fallido: $error';
  }

  @override
  String get nationality => 'Nacionalidad:';

  @override
  String get overview => 'Resumen';

  @override
  String get setting => 'Configuración';

  @override
  String get paymentHistory => 'Historial de Pagos';

  @override
  String get signalsPlan => 'Plan de Señales';

  @override
  String get aiMinvest => 'AI Minvest';

  @override
  String get yourTokens => 'Sus Tokens';

  @override
  String get emailNotificationPreferences =>
      'Preferencias de Notificación por Correo Electrónico';

  @override
  String get chooseSignalNotificationTypes =>
      'Elija qué tipos de notificaciones de señal desea recibir por correo electrónico';

  @override
  String get allSignalNotifications => 'Todas las Notificaciones de Señal';

  @override
  String get cryptoSignals => 'Señales Cripto';

  @override
  String get forexSignals => 'Señales Forex';

  @override
  String get goldSignals => 'Señales de Oro';

  @override
  String get updatePasswordSecure =>
      'Actualice su contraseña para mantener su cuenta segura';

  @override
  String get searchLabel => 'Buscar:';

  @override
  String get filterBy => 'Filtrar por:';

  @override
  String get allTime => 'Todo el Tiempo';

  @override
  String get startDate => 'Fecha de Inicio:';

  @override
  String get endDate => 'Fecha de Finalización:';

  @override
  String get deactivate => 'Desactivar';

  @override
  String get unlimited => 'Ilimitado';

  @override
  String get tenLeft => '10 restantes';

  @override
  String get termsOfRegistrationContent =>
      'Please read all the terms and agreements below carefully before proceeding with the next steps in our system.\nBy registering an account on the Signal GPT system, you confirm and understand that you have read and fully agreed to all the terms stated in these Terms and Conditions.\n\n1. Introduction and Scope of Application\n\nThis policy regulates the collection, use, sharing, and protection of users’ personal information when accessing and using the products and services of the Signal GPT system – a technology and artificial intelligence platform owned and operated by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED (hereinafter referred to as “we” or “us”).\nBy registering an account or using Signal GPT’s products, you agree that such action constitutes a legally binding commitment between you and us, equivalent to an electronic contract.\n\n2. Account Registration\n\nTo access and use certain services on Signal GPT, you must register a valid account.\nWhen registering, you are required to provide complete and accurate personal information, including your full name, email address, phone number, or any other information as requested.\nAfter registration, you must confirm your email to activate the account. All notifications about your account, promotions, or system updates will be sent to this email address.\nIf the information you provide is inaccurate or incomplete, you will be solely responsible for any incidents or damages arising from it.\n\n3. Terms of Use\n\nWhen participating in the Signal GPT system, you are obligated to comply with all of the following:\nThe operating principles of the platform;\nPayment terms;\nPersonal data privacy policy;\nRelevant laws and regulations in effect.\nIn the event of a violation, EZTRADE reserves the right to temporarily suspend or permanently delete your account, and may transfer the case to competent authorities if necessary.\n\n4. Personal Data Privacy Policy\n\n4.1. Purpose and Scope of ... [truncated]';

  @override
  String get operatingPrinciplesContent =>
      'Please read all terms and agreements below carefully before proceeding with the next steps in our system. \nBy registering an account on the Signal GPT system, you confirm and understand that you have read and fully agreed to all the terms stated in these Terms and Conditions.\n\nOPERATING RULES\n\n1. Legal Information\n\nSystem Owner:\nEZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED\nAddress: No. 8 Do Hanh Street, Hai Ba Trung Ward, Hanoi City, Vietnam\nBusiness/Tax Code: 0110057263\nPhone: 0862 600 626\n\n2. Scope of Application\n\nThese Operating Principles apply to all users, learners, partners, and collaborators who participate in or use the products and services within the Signal GPT system, including websites, applications, training platforms, and other online channels managed by EZTRADE.\nBy registering an account or using the services of Signal GPT, users are deemed to have read, understood, and agreed to all the terms set forth in these regulations.\n\n3. Definitions\n\n“Signal GPT” refers to the technology and artificial intelligence platform owned by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED.\n“Customer” / “User” / “Learner” refers to any individual or organization that registers, accesses, or uses the services and products on the Signal GPT system.\n“We” / “Administration” refers to the management team representing EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED, responsible for operating and managing the system.\n“Products” / “Services” include learning packages, analytical newsletters, AI trading signals, analytical tools, or any digital content provided by Signal GPT.\n\n4. Usage Rules and Information Security\n\nUsers must provide accurate and complete information when registering an account.\nSignal GPT is committed to protecting personal information and will not disclose it to third parties unless required by competent authorities.\nUsers are responsible for maintaining the confidentiality of their account and pa... [truncated]';

  @override
  String get termsAndConditionsContent =>
      'By opening an account to participate in the Signal GPT system, you confirm that you have read, understood, and agreed to all the contents of these Account Opening Terms and Conditions.\nThe latest updates (if any) will be published here, and Signal GPT will not send separate notifications to each customer. Therefore, please visit this page regularly to stay informed about the most recent policies.\n\n1. General Agreement\n\nSignal GPT is a technology and artificial intelligence platform owned by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED. By opening an account on this system, you agree to participate in and use the services and products provided by EZTRADE.\nAccount registration and activation are considered an electronic contract between you and Signal GPT, which has the same legal validity as a civil contract under the laws of Vietnam.\n\n2. Personal Account Information and Privacy\n\n2.1. Purpose and Scope of Information Collection\n\nTo access and use certain Signal GPT services, you must provide basic personal information, including:\nFull name;\nEmail address;\nContact phone number;\nOther information (if any) necessary for verification, support, or access authorization.\nAll information provided must be accurate, truthful, and lawful. Signal GPT shall not be responsible for any losses or disputes arising from false, missing, or fraudulent information provided by the user.\nAdditionally, the system may automatically collect certain technical data, such as:\nIP address, browser type, and language used;\nAccess time and pages viewed within the system.\nThis information helps Signal GPT improve performance, enhance security, and optimize user experience.\n\n2.2. Scope of Information Use\n\nYour personal information is collected and used for legitimate purposes, including:\nManaging accounts, verifying users, and maintaining services;\nSending notifications related to services, accounts, promotions, or policy changes;\nProv... [truncated]';

  @override
  String get performance => 'Rendimiento';

  @override
  String get minvestSupport => 'Soporte Minvest';

  @override
  String get leaveMessagePart1 =>
      'Por favor deje un mensaje, nuestro equipo responderá lo antes posible. También puede contactar a ';

  @override
  String get chatWhatsApp => 'WhatsApp';

  @override
  String get leaveMessagePart2 => ' +84 969 156 969 para soporte rápido.';

  @override
  String get currentPlan => 'Current Plan';

  @override
  String get standard => 'STANDARD';

  @override
  String get availableTokens => 'Available Tokens';

  @override
  String get subscriptions => 'Subscriptions';

  @override
  String get usesTokenPerView => 'Uses 1 Token per view';

  @override
  String get unlimitedAccess => 'Unlimited Access';

  @override
  String get activeElite => 'Active (Elite)';

  @override
  String get active => 'Active';

  @override
  String get inactive => 'Inactive';

  @override
  String get transactionHistory => 'Transaction History';

  @override
  String get noTransactionsFound => 'No transactions found.';

  @override
  String get colDate => 'Date';

  @override
  String get colProduct => 'Product';

  @override
  String get colAmount => 'Amount';

  @override
  String get colMethod => 'Method';

  @override
  String get colStatus => 'Status';

  @override
  String get statusSuccess => 'Success';

  @override
  String get featureForVipOnly =>
      'This feature is only for VIP customers, please upgrade to receive notifications.';

  @override
  String get changePassword => 'Change Password';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmNewPassword => 'Confirm New Password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get passwordUpdateSuccess => 'Password updated successfully';

  @override
  String passwordUpdateFailed(String error) {
    return 'Failed to update password: $error';
  }

  @override
  String get reauthFailed => 'Incorrect current password';

  @override
  String get signInRequired => 'Inicio de sesión requerido';

  @override
  String get signInToExploreSignal =>
      '¡Inicia sesión para explorar esta señal de trading!';
}
