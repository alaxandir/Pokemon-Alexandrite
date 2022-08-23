const fs = require('fs');

fs.readFile('PBS/trainers.txt', 'utf8', (err, data) => {
    if (err) {
        console.error(err);
        return;
    }
    const res = data.split('Pokemon = ');
    const pokeList = res.map(p => p.slice(0, p.indexOf(',')));
    pokeList.shift();
    
    let output = {};  
    pokeList.map((pokemon, i) => {
        if (!output[pokemon]) output[pokemon] = 1;
        else {
            output[pokemon]++; 
        }
    });

    const sortedPokemon = 
        Object.keys(output)
            .map(o => { return { [o]: output[o] }})
            .sort((a,b) => {
                return b[Object.keys(b)] - a[Object.keys(a)];
            })
            .map(el => `${Object.keys(el).shift()}: ${el[Object.keys(el).shift()]}`)
            .join('\n')
            .toString();                                                                

    // console.log(output);
    fs.writeFileSync('./pokeCount.txt', sortedPokemon, err => {});
});



// usage: node pokeCount.js or Press F5 in vscode
// see output in pokeCount.txt