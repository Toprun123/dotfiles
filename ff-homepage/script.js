fetch('https://programming-quotesapi.vercel.app/api/random')
    .then(response => response.json())
    .then(quote => {
        document.getElementById('quote').innerText = quote.quote;
        document.getElementById('author').innerText = quote.author;
        console.log(quote);
    });
