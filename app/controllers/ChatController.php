<?php
declare(strict_types=1);

class ChatController
{
    public function index(): void
    {
        Auth::requireLogin();
        $conversations = Conversation::forUser(Auth::id());

        if (empty($conversations)) {
            $this->renderEmpty($conversations);
            return;
        }

        $this->renderConversation((int) $conversations[0]['id'], $conversations);
    }

    public function show(string $id): void
    {
        Auth::requireLogin();
        $conversations = Conversation::forUser(Auth::id());
        $this->renderConversation((int) $id, $conversations);
    }

    private function renderEmpty(array $conversations): void
    {
        View::render('chat/index', [
            'conversations' => $conversations,
            'active' => null,
            'messages' => [],
            'tracks' => Track::enrolledForUser(Auth::id()),
            'noFooter' => true,
            'extraScripts' => ['assets/js/chat.js'],
        ]);
    }

    private function renderConversation(int $id, array $conversations): void
    {
        if (!Conversation::belongsToUser($id, Auth::id())) {
            $this->renderEmpty($conversations);
            return;
        }

        $active = Conversation::find($id);
        $messages = Conversation::messages($id);

        View::render('chat/index', [
            'conversations' => $conversations,
            'active' => $active,
            'messages' => $messages,
            'tracks' => Track::enrolledForUser(Auth::id()),
            'noFooter' => true,
            'extraScripts' => ['assets/js/chat.js'],
        ]);
    }

    public function createConversation(): void
    {
        Auth::requireLogin();
        if (!Request::checkCsrf()) {
            Router::redirect('chat');
            return;
        }

        $trackId = Request::input('track_id') ? (int) Request::input('track_id') : null;
        $title = 'Nouvelle conversation';

        if ($trackId) {
            $track = Track::find($trackId);
            if ($track && Track::isEnrolled(Auth::id(), $trackId)) {
                $title = 'Mentor — ' . $track['title'];
            } else {
                $trackId = null;
            }
        }

        $id = Conversation::create(Auth::id(), $trackId, null, $title);
        Router::redirect("chat/{$id}");
    }

    /** Endpoint AJAX : envoie un message et récupère la réponse du mentor IA. */
    public function send(string $id): void
    {
        Auth::requireLogin();

        if (!Request::checkCsrf()) {
            View::json(['ok' => false, 'error' => 'Jeton CSRF invalide.'], 419);
            return;
        }

        $userId = Auth::id();
        if (!Conversation::belongsToUser((int) $id, $userId)) {
            View::json(['ok' => false, 'error' => 'Conversation introuvable.'], 404);
            return;
        }

        $message = trim((string) Request::input('message', ''));
        if ($message === '' || mb_strlen($message) > 4000) {
            View::json(['ok' => false, 'error' => 'Message vide ou trop long.'], 422);
            return;
        }

        $conversation = Conversation::find((int) $id);
        $user = Auth::user();
        $track = $conversation['track_id'] ? Track::find((int) $conversation['track_id']) : null;
        $lesson = $conversation['lesson_id'] ? Lesson::findWithContext((int) $conversation['lesson_id']) : null;

        Conversation::addMessage((int) $id, 'user', $message);

        $history = array_map(fn ($m) => ['role' => $m['role'], 'content' => $m['content']], Conversation::messages((int) $id));
        // On ne garde que les 20 derniers échanges pour limiter la taille du contexte.
        $history = array_slice($history, -20);

        $systemPrompt = MentorPromptBuilder::build($user, $track, $lesson);
        $result = AIService::reply($systemPrompt, $history);

        Conversation::addMessage((int) $id, 'assistant', $result['content']);

        View::json([
            'ok' => $result['ok'],
            'reply' => $result['content'],
            'reply_html' => View::markdown($result['content']),
        ]);
    }
}
