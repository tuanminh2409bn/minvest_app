// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get accountUpgradedSuccessfully => 'CONTA ATUALIZADA COM SUCESSO';

  @override
  String get lotPerWeek => 'Lot/semana';

  @override
  String get tableValueFull => 'completo';

  @override
  String get tableValueFulltime => 'tempo integral';

  @override
  String get packageTitle => 'PACOTE';

  @override
  String get duration1Month => '1 mês';

  @override
  String get duration12Months => '12 meses';

  @override
  String get featureReceiveAllSignals => 'Receber todos os sinais do dia';

  @override
  String get featureAnalyzeReason => 'Analisar o motivo da entrada na ordem';

  @override
  String get featureHighPrecisionAI => 'Sinal de IA de alta precisão';

  @override
  String get iapStoreNotAvailable =>
      'A loja não está disponível neste dispositivo.';

  @override
  String iapErrorLoadingProducts(Object message) {
    return 'Erro ao carregar produtos: $message';
  }

  @override
  String get iapNoProductsFound =>
      'Nenhum produto encontrado. Verifique a configuração da sua loja.';

  @override
  String iapTransactionError(Object message) {
    return 'Erro na transação: $message';
  }

  @override
  String iapVerificationError(Object message) {
    return 'Erro de verificação: $message';
  }

  @override
  String iapUnknownError(Object error) {
    return 'Ocorreu um erro desconhecido: $error';
  }

  @override
  String get iapProcessingTransaction => 'Processando transação...';

  @override
  String get orderInfo1Month => 'Pagamento pelo pacote Elite de 1 mês';

  @override
  String get orderInfo12Months => 'Pagamento pelo pacote Elite de 12 meses';

  @override
  String get iapNotSupportedOnWeb =>
      'Compras no aplicativo não são suportadas na versão web.';

  @override
  String get vnpayPaymentTitle => 'PAGAMENTO VNPAY';

  @override
  String get creatingOrderWait => 'Criando pedido, aguarde...';

  @override
  String errorWithMessage(Object message) {
    return 'Erro: $message';
  }

  @override
  String get cannotConnectToServer =>
      'Não foi possível conectar ao servidor. Tente novamente.';

  @override
  String get transactionCancelledOrFailed =>
      'A transação foi cancelada ou falhou.';

  @override
  String get cannotCreatePaymentLink =>
      'Não foi possível criar o link de pagamento.\nTente novamente.';

  @override
  String get retry => 'Tentar novamente';

  @override
  String serverErrorRetry(Object message) {
    return 'Erro no servidor: $message. Tente novamente.';
  }

  @override
  String get redirectingToPayment =>
      'Redirecionando para a página de pagamento...';

  @override
  String get invalidPaymentUrl =>
      'URL de pagamento inválido recebido do servidor.';

  @override
  String get processingYourAccount => 'Processando sua conta...';

  @override
  String get verificationFailed => 'Verificação falhou!';

  @override
  String get reuploadImage => 'Reenviar imagem';

  @override
  String get accountNotLinked => 'Conta não vinculada ao Minvest';

  @override
  String get accountNotLinkedDesc =>
      'Para obter sinais exclusivos, sua conta Exness deve ser registrada através do link de parceiro Minvest. Crie uma nova conta usando o link abaixo.';

  @override
  String get registerExnessViaMinvest => 'Registrar Exness via Minvest';

  @override
  String get iHaveRegisteredReupload => 'Já me registrei, reenviar';

  @override
  String couldNotLaunch(Object url) {
    return 'Não foi possível abrir $url';
  }

  @override
  String get status => 'Status';

  @override
  String get sentOn => 'Enviado em';

  @override
  String get entryPrice => 'Preço de entrada';

  @override
  String get stopLossFull => 'Stop loss';

  @override
  String get takeProfitFull1 => 'Take profit 1';

  @override
  String get takeProfitFull2 => 'Take profit 2';

  @override
  String get takeProfitFull3 => 'Take profit 3';

  @override
  String get noReasonProvided => 'Nenhum motivo fornecido para este sinal.';

  @override
  String get upgradeToViewReason =>
      'Atualize sua conta para Elite para ver a análise.';

  @override
  String get upgradeToViewFullAnalysis =>
      'Atualize para ver a análise completa';

  @override
  String get welcomeTo => 'Bem-vindo ao';

  @override
  String get appSlogan => 'Aprimore suas negociações com sinais inteligentes.';

  @override
  String get signIn => 'Entrar';

  @override
  String get continueByGoogle => 'Continuar com Google';

  @override
  String get continueByFacebook => 'Continuar com Facebook';

  @override
  String get continueByApple => 'Continuar com Apple';

  @override
  String get loginSuccess => 'Login realizado com sucesso!';

  @override
  String get live => 'AO VIVO';

  @override
  String get end => 'FIM';

  @override
  String get symbol => 'SÍMBOLO';

  @override
  String get aiSignal => 'Sinais de IA';

  @override
  String get ruleSignal => 'SINAL DE REGRA';

  @override
  String get all => 'TODOS';

  @override
  String get upgradeToSeeMore => 'Atualize para ver mais';

  @override
  String get seeDetails => 'ver detalhes';

  @override
  String get notMatched => 'NÃO CORRESPONDIDO';

  @override
  String get matched => 'CORRESPONDIDO';

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
  String get upgrade => 'Atualizar';

  @override
  String get upgradeAccount => 'ATUALIZAR CONTA';

  @override
  String get compareTiers => 'COMPARAR NÍVEIS';

  @override
  String get feature => 'Recurso';

  @override
  String get tierDemo => 'Demo';

  @override
  String get tierVIP => 'VIP';

  @override
  String get tierElite => 'Elite';

  @override
  String get balance => 'Saldo';

  @override
  String get signalTime => 'Hora do sinal';

  @override
  String get signalQty => 'Qtd de sinais';

  @override
  String get analysis => 'Análise';

  @override
  String get openExnessAccount => 'Abrir conta Exness!';

  @override
  String get accountVerificationWithExness => 'Verificação de conta com Exness';

  @override
  String get payInAppToUpgrade => 'Pague no app para atualizar';

  @override
  String get bankTransferToUpgrade => 'Transferência bancária para atualizar';

  @override
  String get accountVerification => 'VERIFICAÇÃO DE CONTA';

  @override
  String get accountVerificationPrompt =>
      'Por favor, carregue uma captura de tela da sua conta Exness para ser autorizado (sua conta deve ser aberta sob o link da Minvest na Exness)';

  @override
  String get selectPhotoFromLibrary => 'Selecionar foto da biblioteca';

  @override
  String get send => 'Enviar';

  @override
  String get accountInfo => 'Informações da Conta';

  @override
  String get accountVerifiedSuccessfully => 'CONTA VERIFICADA COM SUCESSO';

  @override
  String get yourAccountIs => 'Sua conta é';

  @override
  String get returnToHomePage => 'Retornar à página inicial';

  @override
  String get upgradeFailed =>
      'Falha na atualização! Por favor, reenvie a imagem';

  @override
  String get package => 'PACOTE';

  @override
  String get startNow => 'Obter Sinais Agora';

  @override
  String get bankTransfer => 'TRANSFERÊNCIA BANCÁRIA';

  @override
  String get transferInformation => 'INFORMAÇÕES DE TRANSFERÊNCIA';

  @override
  String get scanForFastTransfer => 'Escaneie para transferência rápida';

  @override
  String get contactUs247 => 'Contate-nos 24/7';

  @override
  String get newAnnouncement => 'NOVO ANÚNCIO';

  @override
  String get profile => 'Perfil';

  @override
  String get upgradeNow => 'Atualizar Agora';

  @override
  String get followMinvest => 'Siga a MInvest';

  @override
  String get tabSignal => 'Sinal';

  @override
  String get tabChart => 'Gráfico';

  @override
  String get tabProfile => 'Perfil';

  @override
  String get reason => 'MOTIVO';

  @override
  String get error => 'Erro';

  @override
  String get noSignalsAvailable => 'Nenhum sinal disponível.';

  @override
  String get outOfGoldenHours => 'Fora do Horário Nobre';

  @override
  String get outOfGoldenHoursVipDesc =>
      'Sinais VIP estão disponíveis das 8:00 às 17:00 (GMT+7).\nAtualize para Elite para obter sinais 24/24!';

  @override
  String get outOfGoldenHoursDemoDesc =>
      'Sinais Demo estão disponíveis das 8:00 às 17:00 (GMT+7).\nAtualize sua conta para mais benefícios!';

  @override
  String get yourName => 'Seu Nome';

  @override
  String get yourEmail => 'seu.email@exemplo.com';

  @override
  String get adminPanel => 'Painel de Administração';

  @override
  String get logout => 'Sair';

  @override
  String get confirmLogout => 'Confirmar Saída';

  @override
  String get confirmLogoutMessage => 'Tem certeza de que deseja sair?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get upgradeCardTitle => 'ATUALIZE SUA CONTA';

  @override
  String get upgradeCardSubtitle => 'Para acessar mais recursos';

  @override
  String get upgradeCardSubtitleWeb =>
      'Para desbloquear sinais premium e suporte em tempo integral';

  @override
  String get subscriptionDetails => 'Detalhes da Assinatura';

  @override
  String get notifications => 'Notificações';

  @override
  String get continueAsGuest => 'Continuar como Convidado';

  @override
  String get deleteAccount => 'Excluir Conta';

  @override
  String get deleteAccountWarning =>
      'Tem certeza de que deseja excluir sua conta? Todos os seus dados serão apagados permanentemente e não poderão ser recuperados.';

  @override
  String get delete => 'Excluir';

  @override
  String get privacyPolicy => 'Política de Privacidade';

  @override
  String get termsOfService => 'Termos de Serviço';

  @override
  String get signalStatusMatched => 'CORRESPONDIDO';

  @override
  String get signalStatusNotMatched => 'NÃO CORRESPONDIDO';

  @override
  String get signalStatusCancelled => 'CANCELADO';

  @override
  String get signalStatusSlHit => 'SL ATINGIDO';

  @override
  String get signalStatusTp1Hit => 'TP1 ATINGIDO';

  @override
  String get signalStatusTp2Hit => 'TP2 ATINGIDO';

  @override
  String get signalStatusTp3Hit => 'TP3 ATINGIDO';

  @override
  String get signalStatusRunning => 'EM ANDAMENTO';

  @override
  String get signalStatusClosed => 'FECHADO';

  @override
  String get contactUs => 'Contate-nos';

  @override
  String get tabChat => 'Chat';

  @override
  String get exnessUpgradeNoteForIos =>
      'Para clientes que registraram uma conta Exness através da Minvest, clique em contate-nos para ter sua conta atualizada.';

  @override
  String get chatWelcomeTitle => '👋 Bem-vindo ao Signal GPT!';

  @override
  String get chatWelcomeBody1 =>
      'Por favor, deixe uma mensagem, nossa equipe responderá o mais rápido possível.';

  @override
  String get chatWelcomeBody2 =>
      'Ou contate-nos diretamente via Zalo/WhatsApp: ';

  @override
  String get chatWelcomeBody3 => ' para suporte mais rápido!';

  @override
  String get chatLoginPrompt => 'Por favor, faça login para usar este recurso';

  @override
  String get chatStartConversation => 'Inicie sua conversa';

  @override
  String get chatNoMessages => 'Ainda não há mensagens.';

  @override
  String get chatTypeMessage => 'Digite uma mensagem...';

  @override
  String get chatSupportIsTyping => 'Suporte está digitando...';

  @override
  String chatUserIsTyping(Object userName) {
    return '$userName está digitando...';
  }

  @override
  String get chatSeen => 'Visto';

  @override
  String get chatDefaultUserName => 'Usuário';

  @override
  String get chatDefaultSupportName => 'Suporte';

  @override
  String get signalEntry => 'Entrada';

  @override
  String get price1Month => '\$78';

  @override
  String get price12Months => '\$460';

  @override
  String get foreignTraderSupport =>
      'Para traders estrangeiros, entre em contato via WhatsApp (+84969.15.6969) para suporte';

  @override
  String get signalSl => 'SL';

  @override
  String get upgradeToSeeDetails => 'Atualize para ver detalhes do sinal...';

  @override
  String get buy => 'COMPRA';

  @override
  String get sell => 'VENDA';

  @override
  String get logoutDialogTitle => 'Sessão Expirada';

  @override
  String get logoutDialogDefaultReason =>
      'Sua conta foi logada em outro dispositivo.';

  @override
  String get ok => 'OK';

  @override
  String get contactToUpgrade => 'Contate para atualizar';

  @override
  String get noNotificationsYet => 'Nenhuma notificação ainda.';

  @override
  String daysAgo(int count) {
    return '$count dias atrás';
  }

  @override
  String hoursAgo(int count) {
    return '$count horas atrás';
  }

  @override
  String minutesAgo(int count) {
    return '$count minutos atrás';
  }

  @override
  String get justNow => 'Agora mesmo';

  @override
  String get getSignalsNow => 'Obter Sinais Agora';

  @override
  String get freeTrial => 'Teste Grátis';

  @override
  String get heroTitle => 'Orientando Traders e Crescendo Portfólios';

  @override
  String get heroSubtitle =>
      'O Motor de IA Definitivo – Projetado por Traders Especialistas';

  @override
  String get globalAiInnovationTitle =>
      'Inovação Global em IA para a Próxima Geração de Inteligência de Trading';

  @override
  String get globalAiInnovationDesc =>
      'Transformando o trading tradicional com sinais de IA baseados em nuvem — adaptáveis às notícias e tendências do mercado em tempo real\npara um desempenho mais rápido, preciso e livre de emoções.';

  @override
  String get liveTradingSignalsTitle =>
      'AO VIVO – Sinais de Trading de IA 24/7';

  @override
  String get liveTradingSignalsDesc =>
      'Análises em nuvem em tempo real entregando estratégias de acompanhamento de tendências de alta probabilidade com precisão adaptativa e execução livre de emoções.';

  @override
  String get trendFollowing => 'Seguidor de Tendência';

  @override
  String get realtime => 'Tempo Real';

  @override
  String get orderExplanationEngineTitle => 'Motor de Explicação de Ordens';

  @override
  String get orderExplanationEngineDesc =>
      'Explica configurações de negociação em termos simples — mostrando como as confluências se formam, por que as entradas são feitas e ajudando os traders a aprender com cada decisão.';

  @override
  String get transparent => 'Transparente';

  @override
  String get educational => 'Educacional';

  @override
  String get logical => 'Lógico';

  @override
  String get transparentRealPerformanceTitle =>
      'Transparente - Desempenho Real';

  @override
  String get transparentRealPerformanceDesc =>
      'Veja dados reais sobre precisão do sinal, taxa de sucesso e lucratividade — verificados e rastreáveis em cada negociação';

  @override
  String get results => 'Resultados';

  @override
  String get performanceTracking => 'Rastreamento de Desempenho';

  @override
  String get accurate => 'Preciso';

  @override
  String get predictiveAccuracy => 'Precisão Preditiva';

  @override
  String get improvementInProfitability => 'Melhoria na Lucratividade';

  @override
  String get improvedRiskManagement => 'Gerenciamento de Risco Aprimorado';

  @override
  String get signalsPerformanceTitle => 'Desempenho dos Sinais';

  @override
  String get riskToRewardRatio => 'Relação Risco-Recompensa';

  @override
  String get howRiskComparesToReward => 'Como o risco se compara à recompensa';

  @override
  String get profitLossOverview => 'Visão Geral de Lucro/Perda';

  @override
  String get netGainVsLoss => 'Ganho líquido vs perda';

  @override
  String get winRate => 'Taxa de Vitória';

  @override
  String get percentageOfWinningTrades =>
      'Porcentagem de negociações vencedoras';

  @override
  String get accuracyRate => 'Taxa de Precisão';

  @override
  String get howPreciseOurSignalsAre => 'Quão precisos são nossos sinais';

  @override
  String get realtimeMarketAnalysis => 'Análise de Mercado em Tempo Real';

  @override
  String get realtimeMarketAnalysisDesc =>
      'Nossa IA monitora o mercado continuamente, identificando zonas de convergência técnica e pontos de rompimento confiáveis para que você possa entrar nas negociações no momento certo.';

  @override
  String get saveTimeOnAnalysis => 'Economize Tempo na Análise';

  @override
  String get saveTimeOnAnalysisDesc =>
      'Chega de horas gastas lendo gráficos. Receba estratégias de investimento personalizadas em apenas alguns minutos por dia.';

  @override
  String get minimizeEmotionalTrading => 'Minimize o Trading Emocional';

  @override
  String get minimizeEmotionalTradingDesc =>
      'Com alertas inteligentes, detecção de risco e sinais baseados em dados, não em emoções, você permanece disciplinado e no controle de cada decisão.';

  @override
  String get seizeEveryOpportunity => 'Aproveite Cada Oportunidade';

  @override
  String get seizeEveryOpportunityDesc =>
      'Atualizações de estratégia oportunas entregues diretamente na sua caixa de entrada garantem que você aproveite as tendências do mercado no momento perfeito.';

  @override
  String get minvestAiCoreValueTitle => 'Valor Central da Signal GPT';

  @override
  String get minvestAiCoreValueDesc =>
      'A IA analisa dados de mercado em tempo real continuamente, filtrando insights para identificar oportunidades de investimento rápidas e precisas';

  @override
  String get frequentlyAskedQuestions => 'Perguntas Frequentes (FAQ)';

  @override
  String get faqSubtitle =>
      'Todas as suas perguntas — desde como participar, aos benefícios, até como nossa IA funciona — são respondidas logo abaixo. Se você ainda tiver dúvidas, sinta-se à vontade para nos enviar uma mensagem no Whatsapp';

  @override
  String get maximizeResultsTitle =>
      'Maximize seus resultados com a análise de mercado avançada da Signal GPT e sinais filtrados com precisão';

  @override
  String get elevateTradingWithAiStrategies =>
      'Eleve seu trading com estratégias aprimoradas por IA criadas para consistência e clareza';

  @override
  String get winMoreWithAiSignalsTitle =>
      'Ganhe Mais com Sinais Impulsionados por IA\nem Todos os Mercados';

  @override
  String get winMoreWithAiSignalsDesc =>
      'Nossa IA multi-mercado escaneia Forex, Cripto e Metais em tempo real,\nentregando sinais de trading validados por especialistas —\ncom níveis claros de entrada, stop-loss e take-profit';

  @override
  String get buyLimit => 'Buy limit';

  @override
  String get sellLimit => 'Sell limit';

  @override
  String get smarterToolsTitle =>
      'Ferramentas Mais Inteligentes - Melhores Investimentos';

  @override
  String get smarterToolsDesc =>
      'Descubra os recursos que ajudam você a minimizar riscos, aproveitar oportunidades e aumentar sua riqueza';

  @override
  String get performanceOverviewTitle => 'Visão Geral de Desempenho';

  @override
  String get performanceOverviewDesc =>
      'Nossa IA multi-mercado escaneia Forex, Cripto e Metais em tempo real, entregando sinais de trading validados por especialistas - com níveis claros de entrada, stop-loss e take-profit';

  @override
  String get totalProfit => 'Lucro Total';

  @override
  String get completionSignal => 'Sinal de conclusão';

  @override
  String get onDemandFinancialExpertTitle =>
      'Seu Especialista Financeiro Sob Demanda';

  @override
  String get onDemandFinancialExpertDesc =>
      'Plataforma de IA sugere sinais de trading - autoaprendizagem, analisa o mercado 24/7, não afetada por emoções. Minvest apoiou mais de 10.000 analistas financeiros em sua jornada para encontrar sinais precisos, estáveis e fáceis de aplicar';

  @override
  String get aiPoweredSignalPlatform =>
      'Plataforma de Sinais de Trading Impulsionada por IA';

  @override
  String get selfLearningSystems =>
      'Sistemas de Autoaprendizagem, Insights Mais Nítidos, Negociações Mais Fortes';

  @override
  String get emotionlessExecution =>
      'Execução Sem Emoção Para um Trading Mais Inteligente e Disciplinado';

  @override
  String get analysingMarket247 => 'Analisando o mercado 24/7';

  @override
  String get maximizeResultsFeaturesTitle =>
      'Maximize seus resultados com a análise de mercado avançada da Signal GPT e sinais filtrados com precisão';

  @override
  String get minvestAiRegistrationDesc =>
      'O registro na Signal GPT está aberto agora — as vagas podem fechar em breve enquanto revisamos e aprovamos novos membros';

  @override
  String get currencyPairs => 'Commodity';

  @override
  String get allCurrencyPairs => 'Todos os Pares de Moedas';

  @override
  String get allCommodities => 'Todas as Commodities';

  @override
  String get allCryptoPairs => 'Todos os Pares de Cripto';

  @override
  String get dateRange => 'Intervalo de Datas';

  @override
  String get selectDateRange => 'Selecionar Intervalo de Datas';

  @override
  String get allAssets => 'Todos os Ativos';

  @override
  String get asset => 'Ativo';

  @override
  String get tokenExpired => 'Token expirado';

  @override
  String get tokenLimitReachedDesc =>
      'Você usou seus 10 tokens gratuitos hoje. Atualize seu pacote para ver mais sinais.';

  @override
  String get later => 'Mais tarde';

  @override
  String get created => 'Criado';

  @override
  String get detail => 'Detalhe';

  @override
  String get performanceOverview => 'Visão Geral de Desempenho';

  @override
  String get totalProfitPips => 'Lucro Total (Pips)';

  @override
  String get winRatePercent => 'Taxa de Vitória (%)';

  @override
  String get comingSoon => 'Em breve';

  @override
  String get errorLoadingHistory => 'Erro ao carregar histórico';

  @override
  String get noHistoryAvailable => 'Nenhum histórico de sinal disponível';

  @override
  String get previous => 'Anterior';

  @override
  String get page => 'Página';

  @override
  String get next => 'Próximo';

  @override
  String get date => 'Data';

  @override
  String get timeGmt7 => 'Hora (GMT)';

  @override
  String get orders => 'Ordens';

  @override
  String get pips => 'Pips';

  @override
  String get smallScreenRotationHint =>
      'Tela pequena: gire para paisagem ou role horizontalmente para ver a tabela completa.';

  @override
  String get history => 'Histórico';

  @override
  String get signalsWillAppearHere =>
      'Os sinais aparecerão aqui quando disponíveis';

  @override
  String get pricing => 'Preços';

  @override
  String get choosePlanSubtitle => 'Escolha um plano que funcione para você';

  @override
  String get financialNewsHub => 'Hub de Notícias Financeiras';

  @override
  String get financialNewsHubDesc =>
      'Atualizações críticas. Reações do mercado. Sem ruído – apenas o que os investidores precisam saber.';

  @override
  String get newsTabAllArticles => 'Todos os Artigos';

  @override
  String get newsTabInvestor => 'Investidor';

  @override
  String get newsTabKnowledge => 'Conhecimento';

  @override
  String get newsTabTechnicalAnalysis => 'Análise Técnica';

  @override
  String noArticlesForCategory(Object category) {
    return 'Nenhum artigo para a categoria $category';
  }

  @override
  String get mostPopular => 'Mais popular';

  @override
  String get noPosts => 'Sem postagens';

  @override
  String get relatedArticles => 'Artigos relacionados';

  @override
  String get contactInfoSentSuccess =>
      'Informações de contato enviadas com sucesso.';

  @override
  String contactInfoSentFailed(Object error) {
    return 'Falha ao enviar informações: $error';
  }

  @override
  String get contactPageSubtitle =>
      'Tem perguntas ou precisa de soluções de IA? Deixe-nos saber preenchendo o formulário e entraremos em contato!';

  @override
  String get phone => 'Telefone';

  @override
  String get firstName => 'Primeiro Nome';

  @override
  String get enterFirstName => 'Digite o Primeiro Nome';

  @override
  String get lastName => 'Sobrenome';

  @override
  String get enterLastName => 'Digite o Sobrenome';

  @override
  String get whatAreYourConcerns => 'Quais são suas preocupações?';

  @override
  String get writeConcernsHere => 'Escreva suas preocupações aqui...';

  @override
  String pleaseEnter(Object field) {
    return 'Por favor, insira $field';
  }

  @override
  String get faqQuestion1 => 'Os sinais garantem uma taxa de sucesso de 100%?';

  @override
  String get faqAnswer1 =>
      'Embora nenhum sinal possa ser garantido 100%, a Signal GPT se esforça para manter uma taxa de sucesso estável de 60–80%, apoiada por análises detalhadas e gerenciamento de risco para que você possa tomar a decisão final com maior confiança.';

  @override
  String get faqQuestion2 =>
      'Se eu não quiser depositar imediatamente, ainda posso receber sugestões de sinais?';

  @override
  String get faqAnswer2 =>
      'Ao abrir uma conta, o sistema lhe dará 10 tokens gratuitos, equivalentes a 10 visualizações detalhadas de sinais. Depois disso, você receberá 1 token adicional todos os dias para usar. Se você atualizar para uma conta VIP, desbloqueará muitos recursos avançados e rastreará um número ilimitado de ordens.';

  @override
  String get faqQuestion3 =>
      'Se eu me inscrevi, mas não recebi nenhum sinal, quais passos devo tomar?';

  @override
  String get faqAnswer3 =>
      'O processamento é tipicamente automático. Se você ainda não vir nenhuma sugestão de sinal, entre em contato conosco via Whatsapp para assistência instantânea.';

  @override
  String get faqQuestion4 =>
      'Quantos sinais receberei por dia ao atualizar para uma conta VIP?';

  @override
  String get faqAnswer4 =>
      'Ao atualizar para uma conta VIP, você receberá sinais de trading ilimitados todos os dias. O número de sinais não é fixo, mas depende inteiramente da análise de mercado. Sempre que um ponto de entrada de alta qualidade e alta probabilidade aparecer, a equipe de análise enviará o sinal para você imediatamente.';

  @override
  String get priceLevels => 'Níveis de Preço';

  @override
  String get capitalManagement => 'Gerenciamento de Capital';

  @override
  String freeSignalsLeft(Object count) {
    return '$count sinais gratuitos restantes';
  }

  @override
  String get unlimitedSignals => 'Sinais ilimitados';

  @override
  String get goBack => 'Voltar';

  @override
  String get goldPlan => 'Plano Gold';

  @override
  String get perMonth => '/ mês';

  @override
  String get continuouslyUpdating =>
      'Atualizando dados de mercado continuamente 24/7';

  @override
  String get providingBestSignals =>
      'Fornecendo os melhores sinais em tempo real';

  @override
  String get includesEntrySlTp => 'Inclui Entrada, SL, TP';

  @override
  String get detailedAnalysis => 'Análise detalhada e avaliação de cada sinal';

  @override
  String get realTimeNotifications => 'Notificações em tempo real via e-mail';

  @override
  String get signalPerformanceStats => 'Estatísticas de desempenho do sinal';

  @override
  String get companyName => 'EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED';

  @override
  String get enterpriseCodeDetails =>
      'Número de Registro Comercial: 0110057263';

  @override
  String get addressDetails =>
      'Endereço: No. 8 Do Hanh Street, Hai Ba Trung Ward, Cidade de Hanói, Vietnã';

  @override
  String get pagesTitle => 'Páginas';

  @override
  String get legalRegulatoryTitle => 'Legal e Regulatório';

  @override
  String get termsOfRegistration => 'Termos de Registro';

  @override
  String get operatingPrinciples => 'Princípios Operacionais';

  @override
  String get termsConditions => 'Termos e Condições';

  @override
  String get contactTitle => 'Contato';

  @override
  String get navFeatures => 'Recursos';

  @override
  String get navNews => 'Notícias';

  @override
  String get tp1Hit => 'TP1 Atingido';

  @override
  String get tp2Hit => 'TP2 Atingido';

  @override
  String get tp3Hit => 'TP3 Atingido';

  @override
  String get slHit => 'SL Atingido';

  @override
  String get cancelled => 'Cancelado';

  @override
  String get exitedByAdmin => 'Saída pelo Admin';

  @override
  String get signalClosed => 'Fechado';

  @override
  String get errorLoadingPackages => 'Erro ao Carregar Pacotes';

  @override
  String get monthly => 'Mensalmente';

  @override
  String get annually => 'Anualmente';

  @override
  String get whatsIncluded => 'O que está incluído:';

  @override
  String get chooseThisPlan => 'Escolher este plano';

  @override
  String get bestPricesForPremiumAccess =>
      'Melhores Preços para Acesso Premium';

  @override
  String get choosePlanFitsNeeds =>
      'Escolha um plano que atenda às suas necessidades de negócios e comece a automatizar com IA';

  @override
  String get save50Percent => 'ECONOMIZE 50%';

  @override
  String get tryDemo => 'Tentar demo';

  @override
  String get pleaseEnterEmailPassword => 'Por favor, insira e-mail e senha';

  @override
  String loginFailed(String error) {
    return 'Login falhou: $error';
  }

  @override
  String get welcomeBack => 'Bem-vindo de Volta';

  @override
  String get signInToContinue => 'Faça login na sua conta para continuar';

  @override
  String get or => 'ou';

  @override
  String get email => 'E-mail';

  @override
  String get emailHint => 'exemplo123@gmail.com';

  @override
  String get password => 'Senha';

  @override
  String get enterPassword => 'Digite a Senha';

  @override
  String get forgotPassword => 'Esqueceu sua senha?';

  @override
  String get createNewAccount => 'Crie uma nova conta aqui!';

  @override
  String get signUp => 'Inscrever-se';

  @override
  String get signUpAccount => 'Inscrever Conta';

  @override
  String get enterPersonalData =>
      'Insira seus dados pessoais para criar sua conta';

  @override
  String get nameLabel => 'Nome *';

  @override
  String get enterNameHint => 'Digite o Nome';

  @override
  String get emailLabel => 'E-mail *';

  @override
  String get passwordLabel => 'Senha *';

  @override
  String get phoneLabel => 'Telefone';

  @override
  String get continueButton => 'Continuar';

  @override
  String get fillAllFields =>
      'Por favor, preencha todos os campos obrigatórios.';

  @override
  String get accountCreatedSuccess => 'Conta criada com sucesso.';

  @override
  String signUpFailed(String error) {
    return 'Falha na inscrição: $error';
  }

  @override
  String get nationality => 'Nacionalidade:';

  @override
  String get overview => 'Visão Geral';

  @override
  String get setting => 'Configuração';

  @override
  String get paymentHistory => 'Histórico de Pagamento';

  @override
  String get signalsPlan => 'Plano de Sinais';

  @override
  String get aiMinvest => 'AI Minvest';

  @override
  String get yourTokens => 'Seus Tokens';

  @override
  String get emailNotificationPreferences =>
      'Preferências de Notificação por E-mail';

  @override
  String get chooseSignalNotificationTypes =>
      'Escolha quais tipos de notificações de sinal você deseja receber via e-mail';

  @override
  String get allSignalNotifications => 'Todas as Notificações de Sinal';

  @override
  String get cryptoSignals => 'Sinais de Cripto';

  @override
  String get forexSignals => 'Sinais de Forex';

  @override
  String get goldSignals => 'Sinais de Ouro';

  @override
  String get updatePasswordSecure =>
      'Atualize sua senha para manter sua conta segura';

  @override
  String get searchLabel => 'Pesquisar:';

  @override
  String get filterBy => 'Filtrar por:';

  @override
  String get allTime => 'Todo o Tempo';

  @override
  String get startDate => 'Data de Início:';

  @override
  String get endDate => 'Data de Término:';

  @override
  String get deactivate => 'Desativar';

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
      'By registering an account to participate in the Signal GPT system, you confirm that you have read, understood, and agreed to all the contents of these Account Opening Terms and Conditions.\nThe latest updates (if any) will be published here, and Signal GPT will not send separate notifications to each customer. Therefore, please visit this page regularly to stay informed about the most recent policies.\n\n1. General Agreement\n\nSignal GPT is a technology and artificial intelligence platform owned by EZTRADE TECHNOLOGY INVESTMENT COMPANY LIMITED. By opening an account on this system, you agree to participate in and use the services and products provided by EZTRADE.\nAccount registration and activation are considered an electronic contract between you and Signal GPT, which has the same legal validity as a civil contract under the laws of Vietnam.\n\n2. Personal Account Information and Privacy\n\n2.1. Purpose and Scope of Information Collection\n\nTo access and use certain Signal GPT services, you must provide basic personal information, including:\nFull name;\nEmail address;\nContact phone number;\nOther information (if any) necessary for verification, support, or access authorization.\nAll information provided must be accurate, truthful, and lawful. Signal GPT shall not be responsible for any losses or disputes arising from false, missing, or fraudulent information provided by the user.\nAdditionally, the system may automatically collect certain technical data, such as:\nIP address, browser type, and language used;\nAccess time and pages viewed within the system.\nThis information helps Signal GPT improve performance, enhance security, and optimize user experience.\n\n2.2. Scope of Information Use\n\nYour personal information is collected and used for legitimate purposes, including:\nManaging accounts, verifying users, and maintaining services;\nSending notifications related to services, accounts, promotions, or policy changes;\nProv... [truncated]';

  @override
  String get performance => 'Desempenho';

  @override
  String get minvestSupport => 'SignalGpt Support';

  @override
  String get leaveMessagePart1 =>
      'Por favor, deixe uma mensagem, nossa equipe responderá o mais rápido possível. Você também pode contatar ';

  @override
  String get chatWhatsApp => 'WhatsApp';

  @override
  String get leaveMessagePart2 => ' +84 969 156 969 para suporte rápido.';

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
  String get signInRequired => 'Login necessário';

  @override
  String get signInToExploreSignal =>
      'Faça login para explorar este sinal de negociação!';
}
