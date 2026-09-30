<?php
declare(strict_types=1);

require __DIR__ . '/app/bootstrap.php';

// ---------------------------------------------------------------------
// Déclaration des routes
// ---------------------------------------------------------------------
Router::get('', [HomeController::class, 'index']);

Router::get('login', [AuthController::class, 'showLogin']);
Router::post('login', [AuthController::class, 'login']);
Router::get('register', [AuthController::class, 'showRegister']);
Router::post('register', [AuthController::class, 'register']);
Router::get('logout', [AuthController::class, 'logout']);

Router::get('forgot-password', [PasswordResetController::class, 'showForgot']);
Router::post('forgot-password', [PasswordResetController::class, 'sendReset']);
Router::get('reset-password/{token}', [PasswordResetController::class, 'showReset']);
Router::post('reset-password/{token}', [PasswordResetController::class, 'resetPassword']);

Router::get('dashboard', [DashboardController::class, 'index']);

Router::get('account/password', [AccountController::class, 'showPassword']);
Router::post('account/password', [AccountController::class, 'updatePassword']);

Router::get('tracks', [TrackController::class, 'index']);
Router::get('tracks/{slug}', [TrackController::class, 'show']);
Router::post('tracks/{slug}/enroll', [TrackController::class, 'enroll']);

Router::get('lessons/{id}', [LessonController::class, 'show']);
Router::post('api/lessons/{id}/complete', [LessonController::class, 'complete']);

Router::get('quiz/{id}', [QuizController::class, 'show']);
Router::post('api/quiz/{id}/submit', [QuizController::class, 'submit']);

Router::get('chat', [ChatController::class, 'index']);
Router::get('chat/{id}', [ChatController::class, 'show']);
Router::post('chat/new', [ChatController::class, 'createConversation']);
Router::post('api/chat/{id}/send', [ChatController::class, 'send']);

Router::get('subscribe', [SubscriptionController::class, 'pricing']);
Router::post('subscribe/pay', [SubscriptionController::class, 'pay']);
Router::get('subscribe/return', [SubscriptionController::class, 'returnFromProvider']);
Router::post('payments/cinetpay/webhook', [SubscriptionController::class, 'webhook']);

Router::get('parrainage', [ReferralController::class, 'index']);
Router::get('certificate/{code}', [CertificateController::class, 'show']);
Router::get('mentors', [MentorController::class, 'index']);

Router::get('admin', [AdminController::class, 'dashboard']);
Router::get('admin/tracks', [AdminController::class, 'tracks']);
Router::get('admin/tracks/new', [AdminController::class, 'trackNew']);
Router::post('admin/tracks', [AdminController::class, 'trackStore']);
Router::get('admin/tracks/{id}/edit', [AdminController::class, 'trackEdit']);
Router::post('admin/tracks/{id}/delete', [AdminController::class, 'trackDelete']);
Router::post('admin/tracks/{id}', [AdminController::class, 'trackUpdate']);
Router::get('admin/tracks/{id}', [AdminController::class, 'trackShow']);
Router::post('admin/tracks/{trackId}/modules', [AdminController::class, 'moduleStore']);
Router::post('admin/modules/{id}/delete', [AdminController::class, 'moduleDelete']);
Router::post('admin/modules/{id}', [AdminController::class, 'moduleUpdate']);
Router::get('admin/modules/{moduleId}/lessons/new', [AdminController::class, 'lessonNew']);
Router::post('admin/modules/{moduleId}/lessons', [AdminController::class, 'lessonStore']);
Router::get('admin/lessons/{id}/edit', [AdminController::class, 'lessonEdit']);
Router::post('admin/lessons/{id}/delete', [AdminController::class, 'lessonDelete']);
Router::post('admin/lessons/{id}', [AdminController::class, 'lessonUpdate']);
Router::get('admin/users', [AdminController::class, 'users']);
Router::get('admin/users/whatsapp.csv', [AdminController::class, 'usersWhatsappCsv']);
Router::post('admin/users/{id}/role', [AdminController::class, 'userRole']);
Router::post('admin/users/{id}/toggle', [AdminController::class, 'userToggle']);
Router::get('admin/users/{id}/mentor', [AdminController::class, 'mentorEdit']);
Router::post('admin/users/{id}/mentor', [AdminController::class, 'mentorUpdate']);
Router::get('admin/subscriptions', [AdminController::class, 'subscriptions']);

Router::dispatch();
