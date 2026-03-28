<!DOCTYPE html>
<html lang="tr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FreshGuard — Son Kullanma Tarihi Hatırlatıcı</title>
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:ital,wght@0,300;0,400;0,500;1,300&display=swap" rel="stylesheet">
<style>
  :root {
    --bg: #0a0f0a;
    --bg2: #0e1610;
    --bg3: #121a12;
    --surface: #1a2a1a;
    --surface2: #1f321f;
    --border: #2a3f2a;
    --green: #4ade80;
    --green-dim: #22c55e;
    --green-dark: #16a34a;
    --yellow: #facc15;
    --red: #f87171;
    --text: #e8f0e8;
    --text-dim: #8ba08b;
    --text-faint: #4a5e4a;
    --accent: #86efac;
  }

  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

  html { scroll-behavior: smooth; }

  body {
    background: var(--bg);
    color: var(--text);
    font-family: 'DM Sans', sans-serif;
    font-size: 16px;
    line-height: 1.7;
    overflow-x: hidden;
  }

  /* Noise texture overlay */
  body::before {
    content: '';
    position: fixed;
    inset: 0;
    background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)' opacity='0.04'/%3E%3C/svg%3E");
    pointer-events: none;
    z-index: 1000;
    opacity: 0.6;
  }

  /* ─── NAV ─── */
  nav {
    position: fixed;
    top: 0; left: 0; right: 0;
    z-index: 100;
    padding: 20px 48px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    backdrop-filter: blur(20px);
    background: rgba(10,15,10,0.8);
    border-bottom: 1px solid var(--border);
  }

  .nav-logo {
    font-family: 'Syne', sans-serif;
    font-weight: 800;
    font-size: 1.4rem;
    color: var(--green);
    letter-spacing: -0.02em;
    display: flex;
    align-items: center;
    gap: 10px;
  }

  .nav-logo .dot {
    width: 10px; height: 10px;
    border-radius: 50%;
    background: var(--green);
    animation: pulse 2s infinite;
  }

  @keyframes pulse {
    0%, 100% { opacity: 1; transform: scale(1); }
    50% { opacity: 0.5; transform: scale(0.8); }
  }

  .nav-links {
    display: flex;
    gap: 36px;
    list-style: none;
  }

  .nav-links a {
    color: var(--text-dim);
    text-decoration: none;
    font-size: 0.85rem;
    font-weight: 500;
    letter-spacing: 0.05em;
    text-transform: uppercase;
    transition: color 0.2s;
  }

  .nav-links a:hover { color: var(--green); }

  /* ─── HERO ─── */
  .hero {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: 120px 48px 80px;
    position: relative;
    overflow: hidden;
  }

  .hero-bg {
    position: absolute;
    inset: 0;
    background:
      radial-gradient(ellipse 60% 50% at 80% 50%, rgba(74,222,128,0.06) 0%, transparent 70%),
      radial-gradient(ellipse 40% 60% at 20% 80%, rgba(34,197,94,0.04) 0%, transparent 60%);
  }

  .hero-grid {
    position: absolute;
    inset: 0;
    background-image:
      linear-gradient(var(--border) 1px, transparent 1px),
      linear-gradient(90deg, var(--border) 1px, transparent 1px);
    background-size: 60px 60px;
    opacity: 0.3;
    mask-image: radial-gradient(ellipse 80% 80% at center, black, transparent);
  }

  .hero-tag {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 6px 16px;
    border: 1px solid var(--border);
    border-radius: 100px;
    font-size: 0.78rem;
    color: var(--green);
    letter-spacing: 0.08em;
    text-transform: uppercase;
    margin-bottom: 32px;
    width: fit-content;
    background: rgba(74,222,128,0.05);
  }

  .hero h1 {
    font-family: 'Syne', sans-serif;
    font-size: clamp(3rem, 8vw, 7rem);
    font-weight: 800;
    line-height: 0.95;
    letter-spacing: -0.04em;
    margin-bottom: 32px;
    position: relative;
    z-index: 1;
  }

  .hero h1 .line2 {
    color: var(--green);
    display: block;
  }

  .hero-desc {
    max-width: 560px;
    color: var(--text-dim);
    font-size: 1.1rem;
    line-height: 1.8;
    margin-bottom: 48px;
    position: relative;
    z-index: 1;
  }

  .hero-btns {
    display: flex;
    gap: 16px;
    flex-wrap: wrap;
    position: relative;
    z-index: 1;
  }

  .btn-primary {
    padding: 14px 32px;
    background: var(--green);
    color: #0a0f0a;
    border: none;
    border-radius: 8px;
    font-family: 'Syne', sans-serif;
    font-weight: 700;
    font-size: 0.9rem;
    cursor: pointer;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    transition: transform 0.2s, box-shadow 0.2s;
    letter-spacing: 0.01em;
  }

  .btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 32px rgba(74,222,128,0.3);
  }

  .btn-secondary {
    padding: 14px 32px;
    background: transparent;
    color: var(--text);
    border: 1px solid var(--border);
    border-radius: 8px;
    font-family: 'Syne', sans-serif;
    font-weight: 600;
    font-size: 0.9rem;
    cursor: pointer;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    transition: all 0.2s;
  }

  .btn-secondary:hover {
    border-color: var(--green);
    color: var(--green);
  }

  .hero-stats {
    display: flex;
    gap: 48px;
    margin-top: 72px;
    padding-top: 40px;
    border-top: 1px solid var(--border);
    position: relative;
    z-index: 1;
  }

  .stat-num {
    font-family: 'Syne', sans-serif;
    font-size: 2rem;
    font-weight: 800;
    color: var(--green);
  }

  .stat-label {
    font-size: 0.82rem;
    color: var(--text-dim);
    text-transform: uppercase;
    letter-spacing: 0.06em;
  }

  /* ─── SECTIONS ─── */
  section {
    padding: 100px 48px;
    position: relative;
  }

  .section-label {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 20px;
  }

  .section-label .file-tag {
    font-size: 0.75rem;
    letter-spacing: 0.08em;
    text-transform: uppercase;
    color: var(--green);
    font-family: 'DM Mono', monospace;
    background: rgba(74,222,128,0.08);
    border: 1px solid rgba(74,222,128,0.2);
    padding: 4px 12px;
    border-radius: 4px;
  }

  .section-label .line {
    flex: 1;
    height: 1px;
    background: var(--border);
    max-width: 80px;
  }

  h2.section-title {
    font-family: 'Syne', sans-serif;
    font-size: clamp(2rem, 4vw, 3.5rem);
    font-weight: 800;
    letter-spacing: -0.03em;
    line-height: 1.05;
    margin-bottom: 16px;
  }

  .section-sub {
    color: var(--text-dim);
    max-width: 540px;
    margin-bottom: 64px;
    font-size: 1rem;
  }

  /* ─── IDEA SECTION ─── */
  #idea { background: var(--bg2); }

  .idea-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 32px;
    margin-top: 48px;
  }

  .idea-card {
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: 16px;
    padding: 36px;
    position: relative;
    overflow: hidden;
    transition: border-color 0.3s, transform 0.3s;
  }

  .idea-card:hover {
    border-color: rgba(74,222,128,0.4);
    transform: translateY(-4px);
  }

  .idea-card::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 2px;
    background: linear-gradient(90deg, var(--green), transparent);
  }

  .card-icon {
    font-size: 2rem;
    margin-bottom: 16px;
    display: block;
  }

  .card-title {
    font-family: 'Syne', sans-serif;
    font-weight: 700;
    font-size: 1.2rem;
    margin-bottom: 12px;
    color: var(--text);
  }

  .card-body {
    color: var(--text-dim);
    font-size: 0.95rem;
    line-height: 1.75;
  }

  .idea-card.full { grid-column: 1 / -1; }

  .ai-role-list {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 16px;
    margin-top: 20px;
  }

  .ai-role-item {
    background: rgba(74,222,128,0.06);
    border: 1px solid rgba(74,222,128,0.15);
    border-radius: 10px;
    padding: 16px 20px;
    font-size: 0.9rem;
    color: var(--accent);
    display: flex;
    align-items: center;
    gap: 10px;
  }

  /* ─── USER FLOW ─── */
  #userflow { background: var(--bg); }

  .flow-container {
    display: flex;
    flex-direction: column;
    gap: 0;
    max-width: 900px;
  }

  .flow-step {
    display: grid;
    grid-template-columns: 80px 1fr;
    gap: 0;
    position: relative;
  }

  .flow-left {
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  .flow-num {
    width: 48px; height: 48px;
    border-radius: 50%;
    background: var(--surface);
    border: 2px solid var(--border);
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: 'Syne', sans-serif;
    font-weight: 700;
    font-size: 1rem;
    color: var(--green);
    z-index: 1;
    flex-shrink: 0;
    transition: all 0.3s;
  }

  .flow-step:hover .flow-num {
    background: var(--green);
    color: #0a0f0a;
    border-color: var(--green);
  }

  .flow-connector {
    width: 2px;
    flex: 1;
    background: var(--border);
    margin: 8px 0;
    min-height: 40px;
  }

  .flow-step:last-child .flow-connector { display: none; }

  .flow-content {
    padding: 4px 0 48px 28px;
  }

  .flow-header {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 10px;
  }

  .flow-icon { font-size: 1.4rem; }

  .flow-title {
    font-family: 'Syne', sans-serif;
    font-weight: 700;
    font-size: 1.15rem;
  }

  .flow-desc {
    color: var(--text-dim);
    font-size: 0.95rem;
    line-height: 1.75;
    margin-bottom: 16px;
  }

  .flow-tags {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
  }

  .tag {
    padding: 4px 12px;
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: 100px;
    font-size: 0.78rem;
    color: var(--text-dim);
  }

  /* ─── TECH STACK ─── */
  #techstack { background: var(--bg2); }

  .tech-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 24px;
  }

  .tech-card {
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: 14px;
    padding: 28px;
    transition: all 0.3s;
    cursor: default;
  }

  .tech-card:hover {
    border-color: rgba(74,222,128,0.35);
    background: var(--surface2);
  }

  .tech-category {
    font-size: 0.72rem;
    color: var(--text-faint);
    text-transform: uppercase;
    letter-spacing: 0.1em;
    margin-bottom: 12px;
  }

  .tech-name {
    font-family: 'Syne', sans-serif;
    font-weight: 700;
    font-size: 1.3rem;
    margin-bottom: 8px;
    color: var(--text);
  }

  .tech-alt {
    font-size: 0.82rem;
    color: var(--text-faint);
    margin-bottom: 14px;
  }

  .tech-reason {
    font-size: 0.88rem;
    color: var(--text-dim);
    line-height: 1.65;
    border-top: 1px solid var(--border);
    padding-top: 14px;
    margin-top: 14px;
  }

  .tech-badge {
    display: inline-flex;
    align-items: center;
    padding: 3px 10px;
    border-radius: 4px;
    font-size: 0.72rem;
    font-weight: 600;
    letter-spacing: 0.05em;
    margin-bottom: 14px;
  }

  .badge-primary { background: rgba(74,222,128,0.12); color: var(--green); }
  .badge-alt { background: rgba(250,204,21,0.1); color: var(--yellow); }

  /* ─── FEATURES ─── */
  #features { background: var(--bg); }

  .phases-nav {
    display: flex;
    gap: 12px;
    flex-wrap: wrap;
    margin-bottom: 48px;
  }

  .phase-btn {
    padding: 8px 20px;
    border: 1px solid var(--border);
    border-radius: 8px;
    background: transparent;
    color: var(--text-dim);
    font-family: 'Syne', sans-serif;
    font-weight: 600;
    font-size: 0.82rem;
    cursor: pointer;
    transition: all 0.2s;
    letter-spacing: 0.02em;
  }

  .phase-btn.active,
  .phase-btn:hover {
    background: var(--green);
    color: #0a0f0a;
    border-color: var(--green);
  }

  .phase-content { display: none; }
  .phase-content.active { display: block; }

  .task-list {
    display: flex;
    flex-direction: column;
    gap: 12px;
  }

  .task-item {
    display: flex;
    align-items: flex-start;
    gap: 16px;
    padding: 20px 24px;
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: 12px;
    transition: all 0.2s;
    cursor: default;
  }

  .task-item:hover {
    border-color: rgba(74,222,128,0.3);
    background: var(--surface2);
  }

  .task-check {
    width: 22px; height: 22px;
    border-radius: 50%;
    border: 2px solid var(--border);
    flex-shrink: 0;
    margin-top: 1px;
    transition: all 0.2s;
    cursor: pointer;
    position: relative;
  }

  .task-check.done {
    background: var(--green);
    border-color: var(--green);
  }

  .task-check.done::after {
    content: '✓';
    position: absolute;
    top: 50%; left: 50%;
    transform: translate(-50%, -50%);
    font-size: 12px;
    color: #0a0f0a;
    font-weight: 700;
  }

  .task-id {
    font-family: 'DM Mono', monospace;
    font-size: 0.75rem;
    color: var(--text-faint);
    flex-shrink: 0;
    width: 36px;
    margin-top: 3px;
  }

  .task-text {
    font-size: 0.95rem;
    color: var(--text-dim);
    line-height: 1.6;
  }

  .task-text strong {
    color: var(--text);
    font-weight: 500;
  }

  /* ─── PRIORITY TABLE ─── */
  #priority { background: var(--bg2); }

  .priority-table {
    width: 100%;
    border-collapse: collapse;
    font-size: 0.95rem;
  }

  .priority-table th {
    text-align: left;
    padding: 14px 20px;
    font-family: 'Syne', sans-serif;
    font-weight: 700;
    font-size: 0.8rem;
    letter-spacing: 0.07em;
    text-transform: uppercase;
    color: var(--text-faint);
    border-bottom: 1px solid var(--border);
  }

  .priority-table td {
    padding: 18px 20px;
    border-bottom: 1px solid var(--border);
    vertical-align: top;
    color: var(--text-dim);
  }

  .priority-table tr:hover td { background: rgba(74,222,128,0.02); }

  .priority-badge {
    font-family: 'Syne', sans-serif;
    font-weight: 700;
    font-size: 1.2rem;
  }

  .priority-phase {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 4px 14px;
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: 100px;
    font-size: 0.82rem;
    color: var(--text);
  }

  /* ─── STATUS LEGEND ─── */
  .status-demo {
    display: flex;
    gap: 24px;
    margin-top: 32px;
    flex-wrap: wrap;
  }

  .status-item {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 12px 24px;
    border-radius: 10px;
    font-weight: 500;
    font-size: 0.9rem;
  }

  .status-urgent { background: rgba(248,113,113,0.1); border: 1px solid rgba(248,113,113,0.3); color: var(--red); }
  .status-warning { background: rgba(250,204,21,0.08); border: 1px solid rgba(250,204,21,0.25); color: var(--yellow); }
  .status-ok { background: rgba(74,222,128,0.08); border: 1px solid rgba(74,222,128,0.2); color: var(--green); }

  .status-dot {
    width: 10px; height: 10px;
    border-radius: 50%;
  }

  .status-urgent .status-dot { background: var(--red); }
  .status-warning .status-dot { background: var(--yellow); }
  .status-ok .status-dot { background: var(--green); }

  /* ─── FOOTER ─── */
  footer {
    padding: 40px 48px;
    border-top: 1px solid var(--border);
    display: flex;
    align-items: center;
    justify-content: space-between;
  }

  .footer-logo {
    font-family: 'Syne', sans-serif;
    font-weight: 800;
    color: var(--green);
    font-size: 1.1rem;
  }

  .footer-note {
    font-size: 0.82rem;
    color: var(--text-faint);
  }

  /* ─── ANIMATIONS ─── */
  .fade-in {
    opacity: 0;
    transform: translateY(24px);
    transition: opacity 0.6s ease, transform 0.6s ease;
  }

  .fade-in.visible {
    opacity: 1;
    transform: translateY(0);
  }

  @media (max-width: 768px) {
    nav { padding: 16px 24px; }
    .nav-links { display: none; }
    section { padding: 64px 24px; }
    .hero { padding: 100px 24px 60px; }
    .idea-grid { grid-template-columns: 1fr; }
    .idea-card.full { grid-column: 1; }
    .hero-stats { gap: 28px; flex-wrap: wrap; }
    footer { flex-direction: column; gap: 12px; text-align: center; }
  }
</style>
</head>
<body>

<!-- NAV -->
<nav>
  <div class="nav-logo">
    <div class="dot"></div>
    FreshGuard
  </div>
  <ul class="nav-links">
    <li><a href="#idea">idea.md</a></li>
    <li><a href="#userflow">user-flow.md</a></li>
    <li><a href="#techstack">tech-stack.md</a></li>
    <li><a href="#features">features/</a></li>
    <li><a href="#priority">MVP</a></li>
  </ul>
</nav>

<!-- HERO = README.md -->
<section class="hero" id="readme">
  <div class="hero-bg"></div>
  <div class="hero-grid"></div>

  <div class="hero-tag">
    <span>📄</span> README.md — Proje Genel Bakış
  </div>

  <h1 class="fade-in">
    Son Kullanma
    <span class="line2">Tarihi<br>Hatırlatıcı</span>
  </h1>

  <p class="hero-desc fade-in">
    Buzdolabındaki ürünlerin son kullanma tarihlerini kamera + OCR ile otomatik okuyan,
    bozulmadan önce sizi uyaran ve acil malzemeleri değerlendirmek için
    <strong style="color:var(--accent)">AI destekli tarif önerileri</strong> sunan akıllı bir uygulama.
  </p>

  <div class="hero-btns fade-in">
    <a href="#features" class="btn-primary">✦ Özellikleri İncele</a>
    <a href="#techstack" class="btn-secondary">⊞ Tech Stack</a>
  </div>

  <div class="hero-stats fade-in">
    <div>
      <div class="stat-num">7</div>
      <div class="stat-label">Geliştirme Fazı</div>
    </div>
    <div>
      <div class="stat-num">10</div>
      <div class="stat-label">Gıda Kategorisi</div>
    </div>
    <div>
      <div class="stat-num">3</div>
      <div class="stat-label">Durum Seviyesi</div>
    </div>
    <div>
      <div class="stat-num">AI</div>
      <div class="stat-label">Destekli Tarifler</div>
    </div>
  </div>
</section>

<!-- IDEA = idea.md -->
<section id="idea">
  <div class="section-label">
    <span class="file-tag">idea.md</span>
    <div class="line"></div>
  </div>
  <h2 class="section-title fade-in">Problem &<br>Çözüm Yaklaşımı</h2>
  <p class="section-sub fade-in">Neden bu ürünü yapıyoruz, kimin için ve yapay zeka ne rol üstleniyor?</p>

  <div class="idea-grid">
    <div class="idea-card fade-in">
      <span class="card-icon">🧊</span>
      <div class="card-title">Problem Tanımı</div>
      <div class="card-body">
        Hanehalkının önemli bir kısmı, buzdolabındaki ürünlerin son kullanma tarihini takip edemediği için
        yüksek miktarda gıda israfı yaşamaktadır. Ürünler fark edilmeden bozulur, bu da hem mali kayba
        hem de gıda güvenliği riskine yol açar.
      </div>
    </div>

    <div class="idea-card fade-in">
      <span class="card-icon">👤</span>
      <div class="card-title">Hedef Kullanıcı</div>
      <div class="card-body">
        Alışveriş yapan ve evde yemek hazırlayan bireyler, aileler ve ev hanımları.
        Özellikle süt ürünleri, et ve taze sebze tüketiminin yoğun olduğu haneler öncelikli segmenttir.
        Uygulama sezgisel, kamera merkezli bir UX ile teknik bilgi gerektirmeden kullanılabilir.
      </div>
    </div>

    <div class="idea-card full fade-in">
      <span class="card-icon">🤖</span>
      <div class="card-title">Yapay Zekanın Rolü</div>
      <div class="card-body">
        Bu projede AI üç temel katmanda devreye girer:
      </div>
      <div class="ai-role-list">
        <div class="ai-role-item">
          📷 <span><strong>Görüntü Tanıma (CV)</strong> — Ürünü fotoğraftan tespit et</span>
        </div>
        <div class="ai-role-item">
          🔍 <span><strong>OCR</strong> — Ambalajdaki tarihi oku ve parse et</span>
        </div>
        <div class="ai-role-item">
          📅 <span><strong>Algoritma</strong> — Kırmızı liste & durum sınıflandırması</span>
        </div>
        <div class="ai-role-item">
          👨‍🍳 <span><strong>LLM (Üretken AI)</strong> — Acil malzemelerle tarif öner</span>
        </div>
        <div class="ai-role-item">
          🔔 <span><strong>Akıllı Bildirim</strong> — Kişiselleştirilmiş hatırlatmalar</span>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- USER FLOW = user-flow.md -->
<section id="userflow">
  <div class="section-label">
    <span class="file-tag">user-flow.md</span>
    <div class="line"></div>
  </div>
  <h2 class="section-title fade-in">Kullanıcı Akışı</h2>
  <p class="section-sub fade-in">Alışverişten tarif önerisine adım adım kullanıcı yolculuğu.</p>

  <div class="flow-container">
    <div class="flow-step fade-in">
      <div class="flow-left">
        <div class="flow-num">01</div>
        <div class="flow-connector"></div>
      </div>
      <div class="flow-content">
        <div class="flow-header">
          <span class="flow-icon">🛒</span>
          <div class="flow-title">Alışveriş & Onboarding</div>
        </div>
        <p class="flow-desc">Kullanıcı uygulamayı ilk açtığında kısa bir onboarding akışından geçer: izin talepleri (kamera, bildirim), tercihlerin ayarlanması. Ardından alışverişten dönen ürünler sisteme eklenmek için hazır.</p>
        <div class="flow-tags">
          <span class="tag">Kamera İzni</span>
          <span class="tag">Bildirim İzni</span>
          <span class="tag">Kullanıcı Tercihleri</span>
        </div>
      </div>
    </div>

    <div class="flow-step fade-in">
      <div class="flow-left">
        <div class="flow-num">02</div>
        <div class="flow-connector"></div>
      </div>
      <div class="flow-content">
        <div class="flow-header">
          <span class="flow-icon">📷</span>
          <div class="flow-title">Fotoğraf Çek</div>
        </div>
        <p class="flow-desc">Kullanıcı ürünü kameraya tutar. YOLO / TensorFlow Lite modeliyle nesne tespiti yapılır. Ürün tanındıktan sonra OCR devreye girerek ambalaj üzerindeki son kullanma tarihi okunur ve parse edilir.</p>
        <div class="flow-tags">
          <span class="tag">YOLO / TF Lite</span>
          <span class="tag">Google Vision API</span>
          <span class="tag">EasyOCR</span>
          <span class="tag">GG.AA.YYYY formatları</span>
        </div>
      </div>
    </div>

    <div class="flow-step fade-in">
      <div class="flow-left">
        <div class="flow-num">03</div>
        <div class="flow-connector"></div>
      </div>
      <div class="flow-content">
        <div class="flow-header">
          <span class="flow-icon">💾</span>
          <div class="flow-title">Otomatik Kayıt</div>
        </div>
        <p class="flow-desc">Tanınan ürün adı ve tarih otomatik olarak veritabanına kaydedilir. Kameranın başa çıkamadığı ürünler için manuel giriş formu devreye girer. Kayıt sonrası durum sınıflandırması anında hesaplanır.</p>
        <div class="flow-tags">
          <span class="tag">products tablosu</span>
          <span class="tag">Manuel fallback</span>
          <span class="tag">Anlık durum</span>
        </div>
      </div>
    </div>

    <div class="flow-step fade-in">
      <div class="flow-left">
        <div class="flow-num">04</div>
        <div class="flow-connector"></div>
      </div>
      <div class="flow-content">
        <div class="flow-header">
          <span class="flow-icon">🔔</span>
          <div class="flow-title">Akıllı Hatırlatma</div>
        </div>
        <p class="flow-desc">Günlük çalışan cron job tarih karşılaştırması yapar. ≤2 gün kalan ürünler URGENT, 3–5 gün kalanlar WARNING statüsüne alınır. Push notification veya e-posta/SMS ile kullanıcı bilgilendirilir.</p>
        <div class="flow-tags">
          <span class="tag">Cron Job</span>
          <span class="tag">Push Notification</span>
          <span class="tag">E-posta / SMS</span>
        </div>
        <div class="status-demo">
          <div class="status-item status-urgent"><div class="status-dot"></div> Son 2 gün — URGENT</div>
          <div class="status-item status-warning"><div class="status-dot"></div> 3–5 gün — WARNING</div>
          <div class="status-item status-ok"><div class="status-dot"></div> 6+ gün — OK</div>
        </div>
      </div>
    </div>

    <div class="flow-step fade-in">
      <div class="flow-left">
        <div class="flow-num">05</div>
        <div class="flow-connector"></div>
      </div>
      <div class="flow-content">
        <div class="flow-header">
          <span class="flow-icon">👨‍🍳</span>
          <div class="flow-title">Tarif Önerisi (LLM)</div>
        </div>
        <p class="flow-desc">"Bu malzemelerle ne yapabilirim?" butonuna basıldığında acil ürünler listesi LLM'e prompt olarak gönderilir. Claude / GPT-4 / Llama 3 hızlı ve pratik bir tarif üretir; tarihler geçmişe kaydedilir.</p>
        <div class="flow-tags">
          <span class="tag">Claude API</span>
          <span class="tag">GPT-4</span>
          <span class="tag">Llama 3</span>
          <span class="tag">/recipes/suggest</span>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- TECH STACK = tech-stack.md -->
<section id="techstack">
  <div class="section-label">
    <span class="file-tag">tech-stack.md</span>
    <div class="line"></div>
  </div>
  <h2 class="section-title fade-in">Teknoloji Seçimleri</h2>
  <p class="section-sub fade-in">Kullanılan teknolojiler ve tercih gerekçeleri.</p>

  <div class="tech-grid">
    <div class="tech-card fade-in">
      <div class="tech-category">Nesne Tespiti</div>
      <div class="tech-name">YOLO v8</div>
      <div class="tech-badge badge-primary">✦ Birincil Seçim</div>
      <div class="tech-alt">Alternatif: TensorFlow Lite</div>
      <div class="tech-reason">Gerçek zamanlı tespit için sektör standardı. Mobilde de çalışabilecek hafif versiyonları mevcut. 10 temel gıda kategorisi için ince ayar yapılabilir.</div>
    </div>

    <div class="tech-card fade-in">
      <div class="tech-category">OCR — Metin Tanıma</div>
      <div class="tech-name">Google Vision API</div>
      <div class="tech-badge badge-primary">✦ Birincil Seçim</div>
      <div class="tech-alt">Alternatif: EasyOCR (offline)</div>
      <div class="tech-reason">Yüksek doğruluk oranı, farklı yazı tipleri ve ambalaj tasarımlarına dayanıklılık. EasyOCR ise internet gerektirmeden yerel çalışabilir.</div>
    </div>

    <div class="tech-card fade-in">
      <div class="tech-category">LLM — Tarif Üretici</div>
      <div class="tech-name">Claude API</div>
      <div class="tech-badge badge-primary">✦ Tercihli</div>
      <div class="tech-alt">Alternatif: GPT-4 / Llama 3</div>
      <div class="tech-reason">Uzun bağlamlı prompt işleme, Türkçe dil desteği ve güvenilir yanıt kalitesi. Llama 3 ise açık kaynak ve maliyet avantajı sunar.</div>
    </div>

    <div class="tech-card fade-in">
      <div class="tech-category">Veritabanı</div>
      <div class="tech-name">PostgreSQL</div>
      <div class="tech-badge badge-primary">✦ Önerilen</div>
      <div class="tech-alt">Alternatif: SQLite (yerel)</div>
      <div class="tech-reason">İki tablo yapısı: <code style="color:var(--green)">products</code> ve <code style="color:var(--green)">notifications</code>. İlişkisel yapı, tarih bazlı sorgular için optimize.</div>
    </div>

    <div class="tech-card fade-in">
      <div class="tech-category">Backend API</div>
      <div class="tech-name">FastAPI / Node.js</div>
      <div class="tech-badge badge-primary">✦ Seçim yapılacak</div>
      <div class="tech-alt">REST CRUD + /recipes/suggest</div>
      <div class="tech-reason">FastAPI: Python ekosistemiyle CV/ML entegrasyonu kolay. Node.js: JavaScript full-stack tercih edilirse. Her ikisi de hızlı prototiplemeye uygun.</div>
    </div>

    <div class="tech-card fade-in">
      <div class="tech-category">Zamanlayıcı</div>
      <div class="tech-name">Cron Job</div>
      <div class="tech-badge badge-primary">✦ Temel Bileşen</div>
      <div class="tech-alt">Alternatif: Celery Beat</div>
      <div class="tech-reason">Her gün çalışarak tarih karşılaştırması yapar ve bildirim servisini tetikler. Stabilitesi kritik; izleme zorunlu.</div>
    </div>

    <div class="tech-card fade-in">
      <div class="tech-category">CI/CD & İzleme</div>
      <div class="tech-name">Sentry + GitHub Actions</div>
      <div class="tech-badge badge-alt">⊞ Faza 7</div>
      <div class="tech-alt">Loglama + Otomatik Deploy</div>
      <div class="tech-reason">Hata izleme için Sentry, otomatik test ve deploy için GitHub Actions pipeline. Staging → Production ortam geçişini yönetir.</div>
    </div>

    <div class="tech-card fade-in">
      <div class="tech-category">Bildirim Servisi</div>
      <div class="tech-name">Firebase FCM</div>
      <div class="tech-badge badge-primary">✦ Push Notification</div>
      <div class="tech-alt">Alternatif: Twilio (SMS)</div>
      <div class="tech-reason">Mobil push notification için ücretsiz ve güvenilir. SMS/e-posta kanalı için Twilio veya SendGrid entegre edilebilir.</div>
    </div>
  </div>
</section>

<!-- FEATURES = features/ -->
<section id="features">
  <div class="section-label">
    <span class="file-tag">features/</span>
    <div class="line"></div>
  </div>
  <h2 class="section-title fade-in">Tüm Görev Listesi</h2>
  <p class="section-sub fade-in">7 geliştirme fazı boyunca uygulanacak tüm özellikler ve görevler.</p>

  <div class="phases-nav">
    <button class="phase-btn active" onclick="showPhase('f1')">Faza 1 — Altyapı</button>
    <button class="phase-btn" onclick="showPhase('f2')">Faza 2 — CV + OCR</button>
    <button class="phase-btn" onclick="showPhase('f3')">Faza 3 — Takip</button>
    <button class="phase-btn" onclick="showPhase('f4')">Faza 4 — AI Tarif</button>
    <button class="phase-btn" onclick="showPhase('f5')">Faza 5 — UI/UX</button>
    <button class="phase-btn" onclick="showPhase('f6')">Faza 6 — Test</button>
    <button class="phase-btn" onclick="showPhase('f7')">Faza 7 — Yayın</button>
  </div>

  <!-- Faza 1 -->
  <div class="phase-content active" id="f1">
    <div class="task-list">
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">1.1</div><div class="task-text"><strong>Proje iskeleti</strong> — klasör yapısı, ortam değişkenleri, <code>.env</code> şablonu</div></div>
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">1.2</div><div class="task-text"><strong>Veritabanı şeması</strong> — <code>products</code> (id, name, entry_date, expiry_date, status) + <code>notifications</code> tabloları</div></div>
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">1.3</div><div class="task-text"><strong>Temel CRUD API</strong> — <code>/products</code> → GET, POST, PUT, DELETE endpoint'leri</div></div>
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">1.4</div><div class="task-text"><strong>Birim testleri</strong> — veri katmanı için hazırlık</div></div>
    </div>
  </div>

  <!-- Faza 2 -->
  <div class="phase-content" id="f2">
    <div class="task-list">
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">2.1</div><div class="task-text"><strong>Kamera arayüzü</strong> — mobil / web entegrasyonu</div></div>
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">2.2</div><div class="task-text"><strong>Nesne tespiti modeli</strong> — 10 temel gıda: süt, et, sebze, yumurta, ekmek, meyve, konserve, içecek, yoğurt, bakliyat (YOLO / TF Lite)</div></div>
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">2.3</div><div class="task-text"><strong>OCR modülü</strong> — tarih okuma, STT & TETT formatları, GG.AA.YYYY varyasyonları (Google Vision / EasyOCR)</div></div>
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">2.4</div><div class="task-text"><strong>Otomatik kayıt</strong> — tanınan ürün + tarih → veritabanı</div></div>
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">2.5</div><div class="task-text"><strong>Manuel giriş formu</strong> — kameranın başa çıkamadığı ürünler için fallback</div></div>
    </div>
  </div>

  <!-- Faza 3 -->
  <div class="phase-content" id="f3">
    <div class="task-list">
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">3.1</div><div class="task-text"><strong>Kırmızı Liste algoritması</strong> — ≤2 gün → URGENT / 3–5 gün → WARNING / 6+ gün → OK</div></div>
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">3.2</div><div class="task-text"><strong>Cron job / zamanlayıcı</strong> — günlük tarih kontrolü</div></div>
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">3.3</div><div class="task-text"><strong>Bildirim servisi</strong> — push (mobil) veya e-posta/SMS; örnek: <em>"Yoğurdunun bozulmasına 2 gün kaldı!"</em></div></div>
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">3.4</div><div class="task-text"><strong>Bildirim tercihleri</strong> — kullanıcı başına sıklık ve kanal yönetimi</div></div>
    </div>
  </div>

  <!-- Faza 4 -->
  <div class="phase-content" id="f4">
    <div class="task-list">
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">4.1</div><div class="task-text"><strong>LLM entegrasyonu</strong> — Claude API / GPT-4 / Llama 3</div></div>
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">4.2</div><div class="task-text"><strong>Prompt şablonu</strong> — giriş: acil ürünler + adet; çıkış: hızlı tarif önerisi</div></div>
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">4.3</div><div class="task-text"><strong>Tarif endpoint</strong> — <code>/recipes/suggest</code></div></div>
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">4.4</div><div class="task-text"><strong>"Bu malzemelerle ne yapabilirim?"</strong> butonu — UI entegrasyonu</div></div>
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">4.5</div><div class="task-text"><strong>Tarif geçmişi</strong> — önerilen tarifleri kaydet ve listele</div></div>
    </div>
  </div>

  <!-- Faza 5 -->
  <div class="phase-content" id="f5">
    <div class="task-list">
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">5.1</div><div class="task-text"><strong>Ana ekran</strong> — ürün listesi + durum renk kodları 🔴 Acil / 🟡 Uyarı / 🟢 Tamam</div></div>
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">5.2</div><div class="task-text"><strong>Ürün detay sayfası</strong> — fotoğraf, tarih, kalan gün sayacı</div></div>
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">5.3</div><div class="task-text"><strong>Bildirim geçmişi ekranı</strong></div></div>
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">5.4</div><div class="task-text"><strong>Tarif öneri ekranı</strong> — malzeme listesi → tarif kartı</div></div>
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">5.5</div><div class="task-text"><strong>Onboarding akışı</strong> — ilk kullanıcı deneyimi, izin talepleri</div></div>
    </div>
  </div>

  <!-- Faza 6 -->
  <div class="phase-content" id="f6">
    <div class="task-list">
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">6.1</div><div class="task-text"><strong>OCR doğruluk testleri</strong> — farklı ambalajlar üzerinde</div></div>
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">6.2</div><div class="task-text"><strong>Nesne tanıma doğrulaması</strong> — 10 gıda kategorisi için precision / recall</div></div>
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">6.3</div><div class="task-text"><strong>Uçtan uca test</strong> — Alışveriş → Fotoğraf → Kayıt → Hatırlatma → Tarif</div></div>
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">6.4</div><div class="task-text"><strong>Performans testleri</strong> — API yanıt süreleri, cron job stabilitesi</div></div>
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">6.5</div><div class="task-text"><strong>Kullanıcı geri bildirimi</strong> — iterasyon planı</div></div>
    </div>
  </div>

  <!-- Faza 7 -->
  <div class="phase-content" id="f7">
    <div class="task-list">
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">7.1</div><div class="task-text"><strong>Ortam yapılandırması</strong> — staging / production</div></div>
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">7.2</div><div class="task-text"><strong>CI/CD pipeline</strong> — otomatik test + deploy</div></div>
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">7.3</div><div class="task-text"><strong>Hata izleme</strong> — Sentry entegrasyonu</div></div>
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">7.4</div><div class="task-text"><strong>Kullanım analitiği</strong> — en çok bozulan ürünler, tarif tıklama oranları</div></div>
      <div class="task-item"><div class="task-check" onclick="this.classList.toggle('done')"></div><div class="task-id">7.5</div><div class="task-text"><strong>Sonraki versiyon yol haritası</strong> — daha fazla kategori, aile/paylaşım modu</div></div>
    </div>
  </div>
</section>

<!-- PRIORITY = MVP -->
<section id="priority">
  <div class="section-label">
    <span class="file-tag">MVP Öncelik Sırası</span>
    <div class="line"></div>
  </div>
  <h2 class="section-title fade-in">Neyi Önce<br>Yapıyoruz?</h2>
  <p class="section-sub fade-in">MVP için kritik path ve öncelik gerekçeleri.</p>

  <table class="priority-table fade-in">
    <thead>
      <tr>
        <th>Öncelik</th>
        <th>Faz</th>
        <th>Gerekçe</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><span class="priority-badge">🥇</span></td>
        <td><span class="priority-phase">🏗️ Faza 1 + 2</span></td>
        <td>Veri olmadan hiçbir şey çalışmaz. Altyapı ve tanıma modülü her şeyin temelidir.</td>
      </tr>
      <tr>
        <td><span class="priority-badge">🥈</span></td>
        <td><span class="priority-phase">⚙️ Faza 3</span></td>
        <td>Hatırlatma = ürünün temel değer önerisi. Bu olmadan uygulama var olma sebebini kaybeder.</td>
      </tr>
      <tr>
        <td><span class="priority-badge">🥉</span></td>
        <td><span class="priority-phase">🎨 Faza 5</span></td>
        <td>Kullanıcı ürünü görmeden ve anlayamadan kullanamaz. UI önce gelir.</td>
      </tr>
      <tr>
        <td><span class="priority-badge" style="font-size:1rem">4️⃣</span></td>
        <td><span class="priority-phase">🤖 Faza 4</span></td>
        <td>Tarif önerisi ek değer sunar, MVP'yi tamamlar ama zorunlu değil.</td>
      </tr>
      <tr>
        <td><span class="priority-badge" style="font-size:1rem">5️⃣</span></td>
        <td><span class="priority-phase">🧪🚀 Faza 6–7</span></td>
        <td>Kalite, test ve ölçek — ürün olgunlaştıkça devreye girer.</td>
      </tr>
    </tbody>
  </table>
</section>

<!-- FOOTER -->
<footer>
  <div class="footer-logo">FreshGuard</div>
  <div class="footer-note">Son Kullanma Tarihi Hatırlatıcı — PRD: son_kullanma_tarihi_hatırlatıcı.txt</div>
</footer>

<script>
  // Phase switcher
  function showPhase(id) {
    document.querySelectorAll('.phase-content').forEach(el => el.classList.remove('active'));
    document.querySelectorAll('.phase-btn').forEach(el => el.classList.remove('active'));
    document.getElementById(id).classList.add('active');
    event.target.classList.add('active');
  }

  // Scroll animations
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(e => {
      if (e.isIntersecting) {
        e.target.classList.add('visible');
      }
    });
  }, { threshold: 0.1, rootMargin: '0px 0px -40px 0px' });

  document.querySelectorAll('.fade-in').forEach(el => observer.observe(el));

  // Stagger cards
  document.querySelectorAll('.idea-grid .idea-card, .tech-grid .tech-card').forEach((el, i) => {
    el.style.transitionDelay = `${i * 0.08}s`;
  });
</script>

</body>
</html>
