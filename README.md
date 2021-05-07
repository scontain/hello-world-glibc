This is a demonstration of a one-step transformation of C native image that runs on Ubuntu:20.04 (`registry.scontain.com:5050/sconecuratedimages/iexecsgx:hello-world-c-ubuntu`) to SCONE-enabled image (`hello-world-c-scone-glibc`).

Execute `sconify.sh` to sconify the native C image.

`sconify.sh` leverages `sconify_image` container that takes an input native image `--from` (`--from=registry.scontain.com:5050/sconecuratedimages/iexecsgx:hello-world-c-ubuntu`) and transforms it to `--to` (`--to=hello-world-c-scone-glibc \`).

All other options related to the `sconify_image` tool can be obtained by running
```
docker run -it --rm  registry.scontain.com:5050/sconecuratedimages/iexec-sconify-image:5.3.3-glibc
```

Before you run the created image you have to:

1) Additionally install https://github.com/oscarlab/graphene-sgx-driver alongside existing `/dev/isgx`
`if` your kernel is < 5.4
you have to patch the `gsgx` driver with: 
```
diff --git a/gsgx.c b/gsgx.c
index 0f71e94..9551b28 100644
--- a/gsgx.c
+++ b/gsgx.c
@@ -30,8 +30,8 @@ static void __enable_fsgsbase(void* v) {
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0)
     write_cr4(read_cr4() | X86_CR4_FSGSBASE);
 #else
-    cr4_set_bits(X86_CR4_FSGSBASE);
-    __write_cr4(__read_cr4() | X86_CR4_FSGSBASE);
+    u64 val = __read_cr4() | X86_CR4_FSGSBASE;
+    asm volatile("mov %0,%%cr4": "+r" (val));
 #endif
 }
```
`or`

2) Run this command, which will install a driver with necessary patch.
```
curl -fsSL https://raw.githubusercontent.com/scontain/SH/master/install_sgx_driver.sh \
| bash -s - install --auto --dkms  -p version -p fsgsbase
```


And finally to run the the sconified image, execute `run.sh`
