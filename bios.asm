; AssilBIOS - Custom x86 Firmware
; Copyright (c) 2026, Assil Kerr
; All rights reserved.
;
; Licensed under the APL License.

BITS 16

SECTION .text
align 4
start:
    cli             ; Disable interrupts
    cld             ; Clear direction flag

    ; Setup COM1 Serial Port (0x3F8)
    mov dx, 0x3F9   ; Interrupt Enable Register
    mov al, 0x00    ; Disable interrupts
    out dx, al

    mov dx, 0x3FB   ; Line Control Register
    mov al, 0x80    ; Enable DLAB
    out dx, al

    mov dx, 0x3F8   ; Divisor Latch Low Byte
    mov al, 0x03    ; 38400 baud
    out dx, al
    mov dx, 0x3F9   ; Divisor Latch High Byte
    mov al, 0x00
    out dx, al

    mov dx, 0x3FB   ; Line Control Register
    mov al, 0x03    ; 8 bits, no parity, 1 stop bit
    out dx, al

    ; Point SI to our welcome message string
    mov si, msg_welcome

.print_string:
    lodsb           ; Load byte from DS:SI into AL, increment SI
    cmp al, 0       ; Is it the null terminator?
    je .done        ; If yes, we are finished printing

    mov bl, al      ; Save character in BL

.wait_tx:
    mov dx, 0x3FD   ; Line Status Register
    in al, dx
    and al, 0x20    ; Check Transmit Holding Register Empty bit
    jz .wait_tx     ; Wait if busy

    mov dx, 0x3F8   ; Data register
    mov al, bl      ; Restore character to AL
    out dx, al      ; Transmit character
    jmp .print_string

.done:
.halt_loop:
    hlt
    jmp .halt_loop

; --- Data Section ---
msg_welcome db "AssilBIOS Booting...", 0x0D, 0x0A, 0

; -------------------------------------------------------------------------
; Pad file to 64KB minus 16 bytes
times 65520 - ($ - $$) db 0

; -------------------------------------------------------------------------
; The Reset Vector
SECTION .reset_vector
    jmp 0xF000:start
    times 16 - ($ - $$) db 0
