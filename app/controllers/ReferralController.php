<?php
declare(strict_types=1);

class ReferralController
{
    public function index(): void
    {
        Auth::requireLogin();
        $user = Auth::user();

        View::render('referral/index', [
            'referralUrl' => rtrim((string) APP_CONFIG['app']['url'], '/') . Router::url('register') . '?ref=' . urlencode($user['referral_code']),
            'rewardDays' => Referral::REWARD_DAYS,
            'rewardedCount' => Referral::countRewardedForUser((int) $user['id']),
            'pendingCount' => Referral::countPendingForUser((int) $user['id']),
        ]);
    }
}
