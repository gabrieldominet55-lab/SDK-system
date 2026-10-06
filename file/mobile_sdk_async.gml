/// @description Inserisci questo codice nell'evento Async - HTTP del tuo oggetto controller
var _id_ricevuto = async_load[? "id"];
var _status = async_load[? "status"];
var _risultato_stringa = async_load[? "result"];

// Verifica se la risposta appartiene a una richiesta del nostro SDK
// Nota: lo sviluppatore dovrà confrontare l'id ricevuto con quello restituito da sdk_invia_dati()
if (_status == 0) { // 0 significa che la richiesta HTTP ha avuto successo
    show_debug_message("[Mobile SDK] Risposta ricevuta dal server.");
    
    // Decodifica il JSON ricevuto dal server
    var _dati_risposta = json_decode(_risultato_stringa);
    
    // Esempio di lettura dei dati
    if (ds_map_exists(_dati_risposta, "successo")) {
        var _successo = _dati_risposta[? "successo"];
        show_debug_message("[Mobile SDK] Stato operazione: " + string(_successo));
    }
    
    ds_map_destroy(_dati_risposta);
} else if (_status < 0) {
    show_debug_message("[Mobile SDK] Errore di rete durante la comunicazione con il server.");
}
