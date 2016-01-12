Shader "Custom/Noise2" {
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
			return frac(sin(p.x * 10.27 + p.y * 35.0) * 45678.23);
		}

		void surf (Input IN, inout SurfaceOutput o) {
			//half4 c = tex2D (_MainTex, IN.uv_MainTex);
			float2 p = IN.uv_MainTex * 0.1;
			float n = hash(p);
			o.Emission = n;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
