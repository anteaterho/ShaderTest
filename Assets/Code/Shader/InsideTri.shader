Shader "Custom/InsideTri" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma target 4.0
		#pragma surface surf Lambert

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};
		
		float dir(float2 d, float2 b)
		{
			return d.x * b.y - d.y * b.x;
		}
		
		bool insideTri(float2 p, float2 a, float2 b, float2 c)
		{
			bool b1 = (p - a, b - a) > 0.0;
			bool b2 = (p - b, c - b) > 0.0;
			bool b3 = (p - c, a - c) > 0.0;
			
			//버텍스 쉐이더에선 뉴메릭 타입만 사용할 수 있는듯 하다.
			return b1 == b2 && b2 == b3;
		}

		void surf (Input IN, inout SurfaceOutput o) {
//			half4 c = tex2D (_MainTex, IN.uv_MainTex);
//			o.Albedo = c.rgb;
//			o.Alpha = c.a;
			float2 p = IN.uv_MainTex * 0.1;
			p = p * 2.0 - 1.0;
			
			float col = 0.0;
			
			float2 a = float2(-0.2, 0.0);
			float2 b = float2(0.2, 0.0);
			float2 c = float2(0.0, 0.2);
			
			if(insideTri(p, a, b, c)) col = 1.0;
			
			float4 n = float4(float3(col),1.0);
			
			o.Emission = n;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
