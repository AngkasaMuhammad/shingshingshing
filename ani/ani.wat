
(module

(global $:chara0		(import "wasmstr" "chara0") i32)
(global $:warna_chara0	(import "wasmstr" "warna_chara0") i32)
(global $:chara0pos0	(import "wasmstr" "chara0pos0") i32)
(global $:zzchara0-inst	(import "wasmstr" "zzchara0 inst") i32)
(global $:posinst		(import "wasmstr" "posinst") i32)
(global $:walking		(import "wasmstr" "walking") i32)
(global $:maju			(import "wasmstr" "maju") i32)
(global $:enco0			(import "wasmstr" "enco0") i32)

(memory $mem0 (export "mem0") 1)

	(func $setanivec7i
		(param $offset i32)
		(param $show i32)
		(param $slot i32)
		(param $bone i32)
		(param $time i32)
		(param $mesh i32)
		(param $index i32)
		(param $attr i32)
		(result i32) ;;offset
		
		
		i32.const 0 local.get $offset i32.add
		local.get $show
		i32.store $mem0

		i32.const 4 local.get $offset i32.add
		local.get $slot
		i32.store $mem0

		i32.const 8 local.get $offset i32.add
		local.get $bone
		i32.store $mem0

		i32.const 12 local.get $offset i32.add
		local.get $time
		i32.store $mem0

		i32.const 16 local.get $offset i32.add
		local.get $mesh
		i32.store $mem0

		i32.const 20 local.get $offset i32.add
		local.get $index
		i32.store $mem0

		i32.const 24 local.get $offset i32.add
		local.get $attr
		i32.store $mem0
		
		
		local.get $offset
		i32.const 28 ;; 7*4
		i32.add ;;offset baru
	)

	(func $anivecstriparr (export "anivecstriparr")
		(param $t i32)
		(param $dt i32)
		(param $env_t i32)
		(param $env_dt i32)
		
		(result i32)
		
		
		
		
		;;show -->> 1 = proses, 0 = skip
		;;slot -->> action slot
		;;bone -->> bone ani
		;;time -->> frame time dalam ani
		;;mesh -->> target mesh
		;;index -->> target instance
		;;attr -->> target attribute
		
		
		
		i32.const 0 ;;offset
		
;; 0 ========= strip0
		i32.const 1 ;;show
		global.get $:warna_chara0 ;;slot
		global.get $:chara0pos0 ;;bone
		local.get $env_t ;;time
		global.get $:zzchara0-inst
		i32.const 0 ;;index
		global.get $:posinst ;;attr
		call $setanivec7i
		
		
		
		
		i32.const 28 ;; 7*4
		i32.div_s ;;jumlah strips
	)

	(func $setanimat3i
		(param $offset i32)
		(param $show i32)
		(param $slot i32)
		(param $time i32)
		(result i32) ;;offset
		
		
		i32.const 0 local.get $offset i32.add
		local.get $show
		i32.store $mem0

		i32.const 4 local.get $offset i32.add
		local.get $slot
		i32.store $mem0

		i32.const 8 local.get $offset i32.add
		local.get $time
		i32.store $mem0
		
		
		local.get $offset
		i32.const 12 ;; 3*4
		i32.add ;;offset baru
	)

	(func $animatstriparr (export "animatstriparr")
		(param $t i32)
		(param $dt i32)
		(param $env_t i32)
		(param $env_dt i32)
		
		(result i32)
		
		
		
		
		;;show -->> 1 = proses, 0 = skip
		;;slot -->> action slot
		;;time -->> frame time dalam ani
		
		
		
		i32.const 0 ;;offset
		
;; [[ STRIP ]]

;; 0 ========= walking
		i32.const 1 ;;show
		global.get $:walking ;;slot
			local.get $env_t ;;time
			i32.const 1000
		call $mod
		call $setanimat3i
		
;; 1 ========= maju
		i32.const 1 ;;show
		global.get $:maju ;;slot
			local.get $env_t ;;time
			i32.const 1000
		call $mod
		call $setanimat3i
		
(;========
--------;)
		
		
		
		
		i32.const 12 ;; 3*4
		i32.div_s ;;jumlah strips
	)

	(func $setanimat4i
		(param $offset i32)
		(param $show i32)
		(param $strip i32)
		(param $mesh i32)
		(param $index i32)
		(result i32) ;;offset
		
		
		i32.const 0 local.get $offset i32.add
		local.get $show
		i32.store $mem0

		i32.const 4 local.get $offset i32.add
		local.get $strip
		i32.store $mem0

		i32.const 8 local.get $offset i32.add
		local.get $mesh
		i32.store $mem0

		i32.const 12 local.get $offset i32.add
		local.get $index
		i32.store $mem0
		
		
		local.get $offset
		i32.const 16 ;; 4*4
		i32.add ;;offset baru
	)

	(func $animattargetarr (export "animattargetarr")
		(param $t i32)
		(param $dt i32)
		(param $env_t i32)
		(param $env_dt i32)
		
		(result i32)
		
		
		
		
		;;show -->> 1 = proses, 0 = skip
		;;strip -->> strip index
		;;mesh -->> target mesh
		;;index -->> target instance
		
		
		i32.const 0 ;;offset
		
;; [[ TARGET ]]

;; 0 ========= chara0|0
		i32.const 1 ;;show
		i32.const 0 ;;strip
		global.get $:chara0 ;;mesh
		i32.const 0 ;;index
		call $setanimat4i
		
;; 1 ========= chara0|0
		i32.const 1 ;;show
		i32.const 1 ;;strip
		global.get $:chara0 ;;mesh
		i32.const 1 ;;index
		call $setanimat4i ;;sampe sini, glitch
		
		
		
		
		i32.const 16 ;; 4*4
		i32.div_s ;;jumlah target
	)

	(func $anienco (export "anienco")
		(param $t i32)
		(param $dt i32)
		(param $env_t i32)
		(param $env_dt i32)
		
		(result i32)
		
		global.get $:enco0
	)

(;










;)

;;florred modulo ((a % b) + b) % b
(func $mod
	(param $a i32)
	(param $b i32)
	(result i32)



  ;; compute a % b
  local.get $a
  local.get $b
  i32.rem_s

  ;; add b
  local.get $b
  i32.add

  ;; compute % b again
  local.get $b
  i32.rem_s
)

)
