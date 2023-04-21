library session_manager;

//export by platform web and app
export 'session_manager.app.dart'
    if (dart.library.html) 'session_manager.web.dart'
    if (dart.library.io) 'session_manager.app.dart';
