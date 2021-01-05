import 'package:wiredash/wiredash.dart';

const String apiKey = 'qj2wb6496zitjts35kp3veci6nlq2sse';
const String projectId = 'synword-4m93osi';

class RussianTranslation extends WiredashTranslations {
  const RussianTranslation() : super();

  @override
  // TODO: implement captureSaveScreenshot
  String get captureSaveScreenshot => "Сохранить";

  @override
  // TODO: implement captureSkip
  String get captureSkip => "Пропустить";

  @override
  // TODO: implement captureSpotlightNavigateMsg
  String get captureSpotlightNavigateMsg => "Перейдите к точке, которую вы хотели бы прикрепить к вашему скриншоту.";

  @override
  // TODO: implement captureSpotlightNavigateTitle
  String get captureSpotlightNavigateTitle => "Навигация";

  @override
  // TODO: implement captureSpotlightScreenCapturedMsg
  String get captureSpotlightScreenCapturedMsg => "Экран захвачен! Вы можете показать где именно ошибка";

  @override
  // TODO: implement captureSpotlightScreenCapturedTitle
  String get captureSpotlightScreenCapturedTitle => "Вы можете рисовать";

  @override
  // TODO: implement captureTakeScreenshot
  String get captureTakeScreenshot => "Продолжить";

  @override
  // TODO: implement feedbackBack
  String get feedbackBack => "Назад";

  @override
  // TODO: implement feedbackCancel
  String get feedbackCancel => "Отменить";

  @override
  // TODO: implement feedbackModeBugMsg
  String get feedbackModeBugMsg => "Подробно расскажите об ошибке и мы исправим ее";

  @override
  // TODO: implement feedbackModeBugTitle
  String get feedbackModeBugTitle => "Сообщить об ошибке";

  @override
  // TODO: implement feedbackModeImprovementMsg
  String get feedbackModeImprovementMsg => "Есть ли у вас идея, которая сделала бы наше приложение лучше? Нам бы очень хотелось это знать!";

  @override
  // TODO: implement feedbackModeImprovementTitle
  String get feedbackModeImprovementTitle => "Запросить новую функцию";

  @override
  // TODO: implement feedbackModePraiseMsg
  String get feedbackModePraiseMsg => "Дайте нам знать, что вам действительно нравится в нашем приложении, может быть, мы сможем сделать его еще лучше.";

  @override
  // TODO: implement feedbackModePraiseTitle
  String get feedbackModePraiseTitle => "Оставить отзыв";

  @override
  // TODO: implement feedbackSave
  String get feedbackSave => "Сохранить";

  @override
  // TODO: implement feedbackSend
  String get feedbackSend => "Отправить";

  @override
  // TODO: implement feedbackStateEmailMsg
  String get feedbackStateEmailMsg => "Если вы хотите получать обновленную информацию о своих отзывах, введите свой адрес электронной почты ниже.";

  @override
  // TODO: implement feedbackStateEmailTitle
  String get feedbackStateEmailTitle => "";

  @override
  // TODO: implement feedbackStateFeedbackMsg
  String get feedbackStateFeedbackMsg => "Мы вас слушаем. Пожалуйста, предоставьте столько информации, сколько необходимо, чтобы мы могли вам помочь.";

  @override
  // TODO: implement feedbackStateFeedbackTitle
  String get feedbackStateFeedbackTitle => "Ваш отзыв ✍";

  @override
  String get feedbackStateIntroMsg => "Что бы вы хотели сделать?";

  @override
  String get feedbackStateIntroTitle => "Привет 👋";

  @override
  // TODO: implement feedbackStateSuccessCloseMsg
  String get feedbackStateSuccessCloseMsg => "Спасибо, что написали свой отзыв!";

  @override
  // TODO: implement feedbackStateSuccessCloseTitle
  String get feedbackStateSuccessCloseTitle => "Закрыть";

  @override
  // TODO: implement feedbackStateSuccessMsg
  String get feedbackStateSuccessMsg => "Вот и все. Большое вам спасибо за помощь!";

  @override
  // TODO: implement feedbackStateSuccessTitle
  String get feedbackStateSuccessTitle => "Спасибо ✌";

  @override
  // TODO: implement inputHintEmail
  String get inputHintEmail => "Email";

  @override
  // TODO: implement inputHintFeedback
  String get inputHintFeedback => "Отзыв";

  @override
  // TODO: implement validationHintEmail
  String get validationHintEmail => "Пожалуйста, введите действительный адрес электронной почты или оставьте это поле пустым.";

  @override
  // TODO: implement validationHintFeedbackEmpty
  String get validationHintFeedbackEmpty => "Пожалуйста, напишите свой отзыв.";

  @override
  // TODO: implement validationHintFeedbackLength
  String get validationHintFeedbackLength => "Ваш отзыв слишком большой.";

}