document.getElementById('chat-form').addEventListener('submit', function (e) {
    e.preventDefault();

    const userInput = document.getElementById('user-input').value;
    const responseArea = document.getElementById('response-area');

    // Clear input
    document.getElementById('user-input').value = '';

    // Add loading state with spinner
    responseArea.innerHTML = `
        <div class="loading">
            <i class="fas fa-spinner fa-spin"></i> Loading...
        </div>
    `;

    // Send request to the server
    fetch('/', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `user_input=${encodeURIComponent(userInput)}`,
    })
    .then(response => response.text())
    .then(html => {
        // Replace the response area with the new HTML
        responseArea.innerHTML = html;
    })
    .catch(error => {
        responseArea.innerHTML = '<div class="response-message">Error: Unable to get a response.</div>';
    });
});