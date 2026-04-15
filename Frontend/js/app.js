const API_URL = '../backend/api.php';

// Gestión de Sesión
async function login(e) {
    e.preventDefault();
    const username = document.getElementById('login-user').value;
    const password = document.getElementById('login-pass').value;
    const errorEl = document.getElementById('login-error');

    try {
        const res = await fetch(`${API_URL}?action=login`, {
            method: 'POST',
            body: JSON.stringify({ username, password })
        });
        const data = await res.json();
        
        if (data.success) {
            document.getElementById('login-screen').classList.add('hidden');
            document.getElementById('main-layout').classList.remove('hidden');
            document.getElementById('user-display').textContent = data.user.nombre;
            showTab('carpetas');
        } else {
            errorEl.textContent = data.error;
            errorEl.classList.remove('hidden');
        }
    } catch (err) {
        errorEl.textContent = "Error de conexión";
        errorEl.classList.remove('hidden');
    }
}

async function logout() {
    await fetch(`${API_URL}?action=logout`);
    document.getElementById('login-screen').classList.remove('hidden');
    document.getElementById('main-layout').classList.add('hidden');
}

// Navegación de pestañas
function showTab(tabId) {
    document.querySelectorAll('.tab-content').forEach(tab => tab.classList.add('hidden'));
    const target = document.getElementById(`tab-${tabId}`);
    if (target) target.classList.remove('hidden');
    
    // Actualizar título y estilos de sidebar
    const titles = { carpetas: 'Carpetas Fiscales', prestamos: 'Gestión de Préstamos', alertas: 'Panel de Alertas', reportes: 'Reportes Estadísticos' };
    document.getElementById('current-tab-title').textContent = titles[tabId];
    
    document.querySelectorAll('.nav-link').forEach(link => {
        const dot = link.querySelector('span:first-child');
        if (link.getAttribute('onclick').includes(tabId)) {
            dot.classList.replace('bg-white/30', 'bg-white');
            link.classList.add('bg-white/10');
        } else {
            dot.classList.replace('bg-white', 'bg-white/30');
            link.classList.remove('bg-white/10');
        }
    });

    if (tabId === 'carpetas') loadCarpetas();
    if (tabId === 'prestamos') loadDependencias();
    if (tabId === 'alertas') loadAlertas();
    if (tabId === 'reportes') loadReportes();
}

// Carga Masiva
async function subirArchivo(e) {
    e.preventDefault();
    const fileInput = document.getElementById('file-input');
    if (!fileInput.files[0]) return;

    const formData = new FormData();
    formData.append('file', fileInput.files[0]);

    try {
        const res = await fetch(`${API_URL}?action=carga_masiva`, {
            method: 'POST',
            body: formData
        });
        const data = await res.json();
        if (data.success) {
            alert(`Éxito: ${data.count} carpetas cargadas.`);
            toggleModal('modal-carga');
            loadCarpetas();
        } else {
            alert(`Error: ${data.error}`);
        }
    } catch (err) {
        alert("Error al procesar el archivo");
    }
}

function toggleModal(modalId) {
    const modal = document.getElementById(modalId);
    modal.classList.toggle('hidden');
    if (modalId === 'modal-prestamo' && !modal.classList.contains('hidden')) {
        loadCarpetasSelector();
    }
}

// Cargar Carpetas
async function loadCarpetas() {
    const res = await fetch(`${API_URL}?action=get_carpetas`);
    const data = await res.json();
    const list = document.getElementById('carpetas-list');
    list.innerHTML = data.map(c => `
        <div class="grid grid-cols-6 p-2 data-row border-b border-black/10 cursor-pointer">
            <span class="data-value">${c.numero_carpeta}</span>
            <span>${c.imputado}</span>
            <span class="text-xs opacity-70">${c.delito}</span>
            <span>${c.agraviado}</span>
            <span class="text-xs font-bold uppercase">${c.estado}</span>
            <span class="data-value text-xs">${c.ubicacion_fisica}</span>
        </div>
    `).join('');
}

// Buscar Carpeta
async function buscarCarpeta() {
    const numero = document.getElementById('search-input').value;
    if (!numero) return loadCarpetas();
    
    try {
        const res = await fetch(`${API_URL}?action=buscar_carpeta&numero=${numero}`);
        if (!res.ok) throw new Error('No ubicado');
        const c = await res.json();
        const list = document.getElementById('carpetas-list');
        list.innerHTML = `
            <div class="grid grid-cols-6 p-2 data-row border-b border-black/10 bg-black text-white">
                <span class="data-value">${c.numero_carpeta}</span>
                <span>${c.imputado}</span>
                <span class="text-xs opacity-70">${c.delito}</span>
                <span>${c.agraviado}</span>
                <span class="text-xs font-bold uppercase">${c.estado}</span>
                <span class="data-value text-xs">${c.ubicacion_fisica}</span>
            </div>
        `;
    } catch (err) {
        alert(err.message);
    }
}

// Registrar Carpeta
async function registrarCarpeta(e) {
    e.preventDefault();
    const formData = new FormData(e.target);
    const data = Object.fromEntries(formData.entries());
    
    const res = await fetch(`${API_URL}?action=registrar_carpeta`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
    });
    
    if (res.ok) {
        toggleModal('modal-registro');
        loadCarpetas();
        e.target.reset();
    }
}

// Cargar Dependencias para el Select
async function loadDependencias() {
    const res = await fetch(`${API_URL}?action=get_dependencias`);
    const data = await res.json();
    const select = document.getElementById('select-dependencia');
    select.innerHTML = '<option value="">Seleccionar Dependencia...</option>' + 
        data.map(d => `<option value="${d.id}">${d.nombre}</option>`).join('');
}

// Cargar Carpetas para el Selector de Préstamo
async function loadCarpetasSelector() {
    const res = await fetch(`${API_URL}?action=get_carpetas`);
    const data = await res.json();
    const container = document.getElementById('carpetas-selector');
    // Solo carpetas activas
    const activas = data.filter(c => c.estado === 'Activo');
    container.innerHTML = activas.map(c => `
        <label class="flex items-center gap-2 p-1 hover:bg-black/5 cursor-pointer text-sm">
            <input type="checkbox" name="carpetas" value="${c.id}" class="accent-black">
            <span class="data-value">${c.numero_carpeta}</span> - ${c.imputado}
        </label>
    `).join('') || '<p class="text-xs opacity-50">No hay carpetas disponibles para préstamo.</p>';
}

// Registrar Préstamo
async function registrarPrestamo(e) {
    e.preventDefault();
    const formData = new FormData(e.target);
    const data = {
        guia_numero: formData.get('guia_numero'),
        dependencia_id: formData.get('dependencia_id'),
        fecha_prestamo: formData.get('fecha_prestamo'),
        plazo_dias: formData.get('plazo_dias'),
        carpetas: Array.from(formData.getAll('carpetas'))
    };
    
    if (data.carpetas.length === 0) return alert('Seleccione al menos una carpeta');

    const res = await fetch(`${API_URL}?action=registrar_prestamo`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
    });
    
    if (res.ok) {
        toggleModal('modal-prestamo');
        loadCarpetas();
        e.target.reset();
        alert('Préstamo registrado con éxito');
    }
}

// Cargar Alertas
async function loadAlertas() {
    const res = await fetch(`${API_URL}?action=get_alertas`);
    const data = await res.json();
    const list = document.getElementById('alertas-list');
    if (data.length === 0) {
        list.innerHTML = '<p class="opacity-50 italic">No hay alertas de vencimiento pendientes.</p>';
        return;
    }
    list.innerHTML = data.map(a => `
        <div class="border-l-4 border-red-600 bg-white p-4 shadow-sm">
            <div class="flex justify-between items-start">
                <div>
                    <h4 class="font-bold text-red-600 uppercase text-xs">Vencimiento Detectado</h4>
                    <p class="text-sm">Guía: <span class="data-value font-bold">${a.guia_numero}</span></p>
                    <p class="text-xs opacity-70">Dependencia: ${a.dependencia}</p>
                </div>
                <div class="text-right">
                    <p class="text-xs uppercase opacity-50">Venció el</p>
                    <p class="data-value font-bold">${a.fecha_vencimiento}</p>
                </div>
            </div>
            <div class="mt-2 pt-2 border-t border-black/5">
                <p class="text-xs font-bold">Carpetas involucradas:</p>
                <p class="text-xs data-value">${a.carpetas}</p>
            </div>
            <button class="mt-4 text-xs underline uppercase font-bold">Generar Nota de Devolución</button>
        </div>
    `).join('');
}

// Cargar Reportes
async function loadReportes() {
    const res = await fetch(`${API_URL}?action=get_reporte_prestamos`);
    const data = await res.json();
    const container = document.getElementById('reporte-dependencia');
    container.innerHTML = data.map(r => `
        <div class="flex justify-between items-center py-2 border-b border-black/5">
            <span class="text-sm">${r.dependencia}</span>
            <span class="data-value font-bold">${r.total_prestamos}</span>
        </div>
    `).join('');
}

// Inicialización
window.onload = () => {
    // El sistema inicia en la pantalla de login por defecto
};
