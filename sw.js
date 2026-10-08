const CACHE="loopy-live-v1";
const SHELL=["./","./index.html","./manifest.webmanifest","./icon.svg"];
self.addEventListener("install",e=>{
  e.waitUntil(caches.open(CACHE).then(c=>c.addAll(SHELL)));
  self.skipWaiting();
});
self.addEventListener("activate",e=>e.waitUntil(self.clients.claim()));
self.addEventListener("fetch",e=>{
  const u=new URL(e.request.url);
  if(u.origin!==location.origin)return;
  e.respondWith(caches.match(e.request).then(c=>c||fetch(e.request).then(r=>{
    const copy=r.clone();
    caches.open(CACHE).then(k=>k.put(e.request,copy));
    return r;
  }).catch(()=>caches.match("./index.html"))));
});
