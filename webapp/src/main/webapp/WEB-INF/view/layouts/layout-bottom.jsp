<%--
  HelixEMR Layout – Bottom Half (closes main content, footer, scripts)
  Include this at the bottom of every authenticated view JSP.
--%>
    </main>

    <!-- Footer -->
    <footer class="helix-footer" role="contentinfo">
        <span>&copy; 2026 <strong>Skillfyme</strong> &mdash; HelixEMR Enterprise Edition</span>
        <span style="display:flex;align-items:center;gap:6px;">
            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="color:var(--helix-primary);">
                <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/>
            </svg>
            v1.0.0 &nbsp;&middot;&nbsp; MPL 2.0 &nbsp;&middot;&nbsp;
            <a href="mailto:support@helixhealth.io" style="color:var(--helix-primary);">support@helixhealth.io</a>
        </span>
    </footer>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.slim.min.js"
        integrity="sha256-kmHvs0B+OpCW5GVHUNjv9rOmY0IvSIRcf7zGUDTDQM8="
        crossorigin="anonymous"></script>
<script>
(function(){
    'use strict';
    /* Animate stat counters up from 0 */
    document.querySelectorAll('.helix-stat-value').forEach(function(el){
        var target = parseInt(el.textContent.replace(/,/g,''), 10);
        if(isNaN(target) || target === 0) return;
        var duration = 900, step = 16;
        var steps = Math.ceil(duration / step);
        var inc = target / steps;
        var current = 0, count = 0;
        var timer = setInterval(function(){
            count++;
            current = count >= steps ? target : Math.floor(inc * count);
            el.textContent = current.toLocaleString();
            if(count >= steps) clearInterval(timer);
        }, step);
    });
})();
</script>
</body>
</html>
