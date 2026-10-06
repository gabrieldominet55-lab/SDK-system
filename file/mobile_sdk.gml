/// @function sdk_inizializza(api_key)
/// @description Inizializza l'SDK con la tua chiave unica.
/// @param {string} api_key La chiave API fornita dalla dashboard.
function sdk_inizializza(_api_key) {
    global.sdk_api_key = _api_key;
    global.sdk_inizializzato = true;
    global.sdk_versione = "1.0.0";
    
    show_debug_message("[Mobile SDK] Inizializzato con successo. Versione: " + global.sdk_versione);
    return 1; // Successo
}

/// @function sdk_invia_dati(endpoint, mappa_dati)
/// @description Invia dati asincroni al server dell'SDK convertendoli in JSON.
/// @param {string} endpoint La rotta del server (es. "salvataggio", "login").
/// @param {Id.DsMap} mappa_dati Una ds_map contenente i dati da inviare.
function sdk_invia_dati(_endpoint, _mappa_dati) {
    if (!variable_global_exists("sdk_inizializzato") || !global.sdk_inizializzato) {
        show_debug_message("[Mobile SDK] Errore: L'SDK non è stato inizializzato!");
        return -1;
    }

    // Trasforma la mappa in una stringa JSON pulita per eliminare i problemi di compatibilità
    var _json_string = json_encode(_mappa_dati);
    
    // Configura l'header per la richiesta web
    var _headers = ds_map_create();
    ds_map_add(_headers, "Content-Type", "application/json");
    ds_map_add(_headers, "Authorization", "Bearer " + global.sdk_api_key);
    
    // Invia la richiesta HTTP asincrona al tuo server
    var _url = "https://tuoservizio.com" + _endpoint;
    var _request_id = http_request(_url, "POST", _headers, _json_string);
    
    // Pulizia della memoria
    ds_map_destroy(_headers);
    
    show_debug_message("[Mobile SDK] Richiesta inviata all'endpoint: " + _endpoint);
    return _request_id; // Restituisce l'ID della richiesta per tracciarla nell'evento Async
}
