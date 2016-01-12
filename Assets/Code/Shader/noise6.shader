﻿Shader "Custom/noise6" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Lambert

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};
		
		float2 hash(float2 p)
		{
			return frac(sin(p.x * 15.30 + p.y * 36.90) * 45678.23);
		}
		
		float noise(float2 p)
		{
			float2 g = floor(p);
			float2 f = frac(p);
			
			float lb = hash(g + float2(0.0, 0.0));
			float rb = hash(g + float2(1.0, 0.0));
			float lt = hash(g + float2(0.0, 1.0));
			float rt = hash(g + float2(1.0, 1.0));
			
			float b = lerp(lb, rb, f.x);
			float t = lerp(lt, rt, f.x);
			
			float res = lerp(b, t, f.y);
			
			return res;
		}
		
		float fbm(float2 p)
		{
			float r = 0.0;
			r += noise(p) / 2.0;
			r += noise(p * 2.0) / 4.0;
			r += noise(p * 4.0) / 8.0;
			r += noise(p * 8.0) / 16.0;
			
			return r;
		}

		void surf (Input IN, inout SurfaceOutput o) {
//			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			float2 p = IN.uv_MainTex * 0.1;
			float n = fbm(p * 10.0);
			o.Emission = n;

		}
		ENDCG
	} 
	FallBack "Diffuse"
}
